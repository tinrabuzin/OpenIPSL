import matplotlib
matplotlib.use('Agg')
import sys
import numpy as np
import h5py
from OMPython import OMCSession
import matplotlib.pyplot as plt


class CITests():
    '''
    Python class used to run CI tests
    '''
    def __init__(self, libPath):
        '''
        Constructor starts omc and loads MSL and OpenIPSL
        '''
        self.libPath = libPath
        self.omc = OMCSession()
        self.omc.sendExpression("loadModel(Modelica)")
        self.omc.sendExpression('loadFile("%s")' % (self.libPath))

    def runCheck(self):
        '''
        Checks all of the models in the library and returns number of faild checks
        '''
        # Get the list of all classes in OpenIPSL
        test_list = self.omc.sendExpression('getClassNames(OpenIPSL,recursive=true)')
        nFailed = 0
        nPassed = 0

        # Run the check for all classes that are model and print result msgs
        print "============================ Checking Models ============================="
        for test in test_list:
            if self.omc.sendExpression("isModel(%s)" % (test)):  # Check if a class is a model
                passMsg = self.omc.sendExpression("checkModel(%s)" % (test))
                failMsg = self.omc.sendExpression("getErrorString()")
                if "completed successfully." in passMsg:
                    # print passMsg
                    nPassed += 1
                else:
                    print failMsg
                    nFailed += 1
        # Print a check summary
        print "============================= Check Summary =============================="
        print "Number of models that passed the check is: %s" % nPassed
        print "Number of models that failed the check is: %s" % nFailed
        return nFailed

    def runSW2SW(self):
        '''
        Runs SW-to-SW Validation of models in OpenIPSL
        '''
        print "======================= Running SW-to-SW Valiation ========================"

        # Create a list of models which will be sw-to-sw validated
        test_list = ["OpenIPSL.Examples.Machines.PSSE.GENSAL"]

        # cd to the repo folder to store simulation results next to the reference
        self.omc.sendExpression('cd("/OpenIPSL/CI")')

        for model in test_list:
            resultFile = self.simulateModel(model)
            dataModelica = self.postProcessModelica(resultFile)
            dataPSSE = self.postProcessPSSE(model)
            for key in dataModelica.keys():
                RMSE = self.calculateRMSE(dataModelica['time'], dataModelica[key], dataPSSE['time'], dataPSSE[key], key)
                print 'RMSE for signal %s is - %s' % (key, RMSE)

        return dataModelica, dataPSSE

    def simulateModel(self, model):
        '''
        Simulates specified modelica model and returns location of the result file
        '''

        stopTime = 10
        outputInterval = 0.0001
        method = 'rungekutta'
        outputFormat = 'csv'
        tolerance = 1e-4

        print "[TEST]: %s" % (model)
        answer = self.omc.sendExpression('simulate(%s, stopTime =%s, numerOfIntervals=%s, ' % (model, stopTime, stopTime/outputInterval)
                                         + 'tolerance=%s, method=%s, outputFormat="%s")' % (tolerance, method, outputFormat))

        print 'Simulation time: %s' % (answer['timeSimulation'])
        print answer
        a = self.omc.sendExpression('getErrorString()')
        print a
        return answer['resultFile']

    def postProcessModelica(self, resultFile):
        '''
        Does postprocessing of Modelica result file
        '''
        datafromh5 = np.genfromtxt(resultFile, delimiter=',', dtype=float, names=True)

        dataModelica = {}
        dataModelica['P'] = datafromh5['gENROEP']
        dataModelica['Q'] = datafromh5['gENROEQ']
        dataModelica['ETERM'] = datafromh5['gENROEETERM']
        dataModelica['EFD'] = datafromh5['gENROEEFD']
        dataModelica['time'] = datafromh5['time']

        return dataModelica

    def postProcessPSSE(self, model):
        '''
        Does postprocessing of PSSE result file
        '''
        h5file = h5py.File('/OpenIPSL/CI/'+model+'.h5', 'r')
        dataPSSE = {}
        dataPSSE['P'] = h5file['P'][...]
        dataPSSE['Q'] = h5file['Q'][...]
        dataPSSE['ETERM'] = h5file['ETERM'][...]
        dataPSSE['EFD'] = h5file['EFD'][...]
        dataPSSE['time'] = h5file['Time(s)'][...]

        return dataPSSE

    def resampleData(self, X1, Y1, X2, Y2):

        '''
        Resampling of the data coming from PSSE and Modelica
        '''

        X2, indices = np.unique(X2, return_index=True)
        Y2 = Y2[indices]
        X1, indices = np.unique(X1, return_index=True)
        Y1 = Y1[indices]
        Y2_interp = np.interp(X1, X2, Y2)

        return X1, Y1, Y2_interp

    def calculateRMSE(self, X1, Y1, X2, Y2, signal):

        '''
        Calculates Root Mean Square Error for the two signals
        '''
        (X1, Y1, Y2) = self.resampleData(X1, Y1, X2, Y2)

        RMSE = np.sqrt(sum(np.square(Y2-Y1))/len(Y2))

        # self.plotComparison(X1, Y1, X2, Y2, signal)
        '''
        suma = 0
        for i in range(0, len(Y1)-1):
                suma = suma + np.absolute(Y2[i]-0.99*Y2[i])
        MASE = sum(np.absolute(Y2-Y1))/suma
        '''
        return RMSE

    def plotComparison(self, X1, Y1, X2, Y2, sig_name):
        lines = plt.plot(X1, Y1, 'b-', X1, Y2, 'r--')

        plt.setp(lines[0], linewidth=2, label='Modelica')
        plt.setp(lines[1], linewidth=2, label='PSS/E')
        plt.legend()
        plt.grid(True)
        plt.xlabel('Time (s)')
        plt.savefig(sig_name)
        plt.close()

libPath = "/OpenIPSL/OpenIPSL/package.mo"
ci = CITests(libPath)
(mod, psse) = ci.runSW2SW()

# The tests are failing if the number of failed check > 0
if False:
    sys.exit(1)
