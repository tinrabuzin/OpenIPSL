within OpenIPSL.Electrical.Solar;

package PowerFactory
  package ElmModels
    model ElmGenstat
      extends OpenIPSL.Electrical.Essentials.pfComponent(final enabledisplayPF = false, final enablefn = true, final enableV_b = false, final enableangle_0 = true, final enablev_0 = true, final enableQ_0 = true, final enableP_0 =          true, final enableS_b = true);
      Real anglev;
      Real anglei;
      Real Vt;
      Real Q(start=Q_0/S_b);
      Real P(start=P_0/S_b);
      Modelica.Blocks.Interfaces.RealInput id_ref annotation(
        Placement(visible = true, transformation(origin = {-108, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput iq_ref annotation(
        Placement(visible = true, transformation(origin = {-108, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput sinref annotation(
        Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput cosref annotation(
        Placement(visible = true, transformation(origin = {-108, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OpenIPSL.Interfaces.PwPin p annotation(
        Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealOutput It annotation(
        Placement(visible = true, transformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    protected
    
    equation
      p.ir = -(id_ref * cosref - iq_ref * sinref);
      p.ii = -(id_ref * sinref + iq_ref * cosref);
      -P = p.vr * p.ir + p.vi * p.ii;
      -Q = p.vi * p.ir - p.vr * p.ii;
      Vt = sqrt(p.vr ^ 2 + p.vi ^ 2);
      anglev = atan2(p.vi, p.vr);
      It = sqrt(p.ii ^ 2 + p.ir ^ 2);
      anglei = atan2(p.ii, p.ir);
      annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(origin = {-69.7, 70.01}, fillPattern = FillPattern.Solid, extent = {{-12.3, -8.18}, {12.3, 8.18}}, textString = "id_ref", fontName = "Arial"), Text(origin = {-63.7, 29.82}, fillPattern = FillPattern.Solid, extent = {{-12.3, -8.18}, {12.3, 8.18}}, textString = "iq_ref", fontName = "Arial"), Text(origin = {24.07, -72.08}, fillPattern = FillPattern.Solid, extent = {{-124.07, -27.92}, {76.07, -8.08}}, textString = "ElmStatgen", fontName = "Arial"), Text(origin = {-63.7, -72.18}, fillPattern = FillPattern.Solid, extent = {{-12.3, -8.18}, {14.3, 8.18}}, textString = "cosref", fontName = "Arial"), Text(origin = {-63.7, -20.18}, fillPattern = FillPattern.Solid, extent = {{-12.3, -8.18}, {12.3, 8.18}}, textString = "sinref", fontName = "Arial"), Ellipse(origin = {50, -48}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {-2, -2}}, endAngle = 360), Line(origin = {-0.000710326, 0.400639}, points = {{0, -25}, {0, 25}}, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10)}, coordinateSystem(initialScale = 0.1)),
        Diagram,
        Documentation(info = "<html>
    <table cellspacing=\"1\" cellpadding=\"1\" border=\"1\">
    <tr>
    <td><p>Reference</p></td>
    <td><p>TBD</p></td>
    </tr>
    <tr>
    <td><p>Last update</p></td>
    <td>TBD</td>
    </tr>
    <tr>
    <td><p>Author</p></td>
    <td><p>Joan Russinol, SmarTS Lab, KTH Royal Institute of Technology</p></td>
    </tr>
    <tr>
    <td><p>Contact</p></td>
    <td><p><a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p></td>
    </tr>
    </table>
    </html>"));
    end ElmGenstat;

    model StaVmeas
    parameter Real Tfe=3/50;
    parameter Real fn=50;
    
    OpenIPSL.Interfaces.PwPin p annotation(
        Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
        Placement(visible = true, transformation(origin = {118, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput fe annotation(
        Placement(visible = true, transformation(origin = {108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real cosphi;
    Real sinphi;
    equation
u = sqrt(p.vr^2 + p.vi^2);
    der(cosphi) = (p.vr/u - cosphi)/Tfe;
    der(sinphi) = (p.vi/u - sinphi)/Tfe;
    if abs(cosphi) > abs(sinphi) then
      fe = 1 + der(sinphi)/cosphi/(2*Modelica.Constants.pi*fn);
    else
      fe = 1 + der(cosphi)/sinphi/(2*Modelica.Constants.pi*fn);
    end if;
    p.ii = 0;
    p.ir = 0;
    annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 90}, extent = {{-100, 10}, {100, -10}}, textString = "StaVmeas"), Text(origin = {0, 50}, extent = {{62, 8}, {100, -10}}, textString = "u"), Text(origin = {0, -50}, extent = {{62, 8}, {100, -10}}, textString = "fe")}));end StaVmeas;
  end ElmModels;

  package WECC
    model PVD1
    
      parameter SI.PerUnit fn;
      parameter SI.PerUnit Imax=1.1 "Maximum allowable total converter current";
      parameter Boolean PqFlag "Priority on current limit flag: 1=P prio.; 0 = Q prio.";
      parameter SI.Time Tg=0.02 "Inverter current regulator time constat";
      parameter SI.PerUnit Xc=0 "Line drop compensation reactance";
      parameter SI.PerUnit Qmx=0.328 "Maximum reactive power";
      parameter SI.PerUnit Qmn=-0.328 "Minimum reactive power";
      parameter SI.PerUnit v0=0.9 "Low voltage threshold for Volt/Var Control";
      parameter SI.PerUnit v1=1.1 "High voltage threshold for Volt/Var Control";
      parameter SI.PerUnit dqdv=0 "Voltage/Var droop compensation";
      parameter SI.PerUnit fdbd=-99 "Frequency deadband over frequency response";
      parameter Real Ddn=0 "Down regulation droop";
      parameter Real vr_recov "Amount of generation to reconnect after voltage disconnection";
      parameter Real fr_recov "Amount of generation to reconnect after frequency disconnection";
      parameter Real Ft0;
      parameter Real Ft1;
      parameter Real Ft2;
      parameter Real Ft3;
      parameter Real Vt0;
      parameter Real Vt1;
      parameter Real Vt2;
      parameter Real Vt3;  
      Modelica.Blocks.Interfaces.RealInput Vt annotation(
        Placement(visible = true, transformation(origin = {-200, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-200, 140}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput It annotation(
        Placement(visible = true, transformation(origin = {-200, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-200, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Math.Gain compensation(k = Xc) annotation(
        Placement(visible = true, transformation(origin = {-150, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add annotation(
        Placement(visible = true, transformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Nonlinear.Limiter numerical_limit(limitsAtInit = true, uMax = Modelica.Constants.inf, uMin = 0.01) annotation(
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation(
        Placement(visible = true, transformation(origin = {90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.QPPriority qppriority(Imax = Imax, PqFlag = PqFlag)  annotation(
        Placement(visible = true, transformation(origin = {130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Division division1 annotation(
        Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder PCurrentController(T = Tg, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 1, y_start = Pref / u_0)  annotation(
        Placement(visible = true, transformation(origin = {170, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder QCurrentController(T = Tg, initType = Modelica.Blocks.Types.Init.InitialOutput, k = -1, y_start = -Qref / u_0)  annotation(
        Placement(visible = true, transformation(origin = {170, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput freq annotation(
        Placement(visible = true, transformation(origin = {-200, 150}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = { -200, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant freq_ref(k = 1)  annotation(
        Placement(visible = true, transformation(origin = {-182, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k1 = -1)  annotation(
        Placement(visible = true, transformation(origin = {-130, 144}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.DeadZone deadZone(deadZoneAtInit = true, uMax = Modelica.Constants.inf, uMin = fdbd)  annotation(
        Placement(visible = true, transformation(origin = {-90, 144}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain frequency_droop(k = Ddn) annotation(
        Placement(visible = true, transformation(origin = {-50, 144}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant active_power_reference(k = Pref) annotation(
        Placement(visible = true, transformation(origin = {-150, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.DeadZone deadband_voltage(deadZoneAtInit = true, uMax = v1, uMin = v0) annotation(
        Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain voltage_droop(k = dqdv) annotation(
        Placement(visible = true, transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = Qmx, uMin = Qmn) annotation(
        Placement(visible = true, transformation(origin = {50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
        Placement(visible = true, transformation(origin = {14, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant reactive_power_reference(k = Qref) annotation(
        Placement(visible = true, transformation(origin = {-70, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Ip annotation(
        Placement(visible = true, transformation(origin = {210, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Iq annotation(
        Placement(visible = true, transformation(origin = {210, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add4 annotation(
        Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

      parameter SI.PerUnit Qref;
      parameter SI.PerUnit Pref;
      parameter SI.PerUnit u_0;
    equation
      connect(It, compensation.u) annotation(
        Line(points = {{-200, -70}, {-162, -70}}, color = {0, 0, 127}));
      connect(compensation.y, add.u2) annotation(
        Line(points = {{-139, -70}, {-130.5, -70}, {-130.5, -76}, {-122, -76}}, color = {0, 0, 127}));
      connect(Vt, add.u1) annotation(
        Line(points = {{-200, -10}, {-128, -10}, {-128, -63}, {-122, -63}, {-122, -64}}, color = {0, 0, 127}));
      connect(numerical_limit.u, Vt) annotation(
        Line(points = {{-82, -10}, {-200, -10}}, color = {0, 0, 127}));
      connect(numerical_limit.y, division.u2) annotation(
        Line(points = {{-59, -10}, {-8, -10}, {-8, -36}, {78, -36}}, color = {0, 0, 127}));
      connect(division.y, qppriority.Iq) annotation(
        Line(points = {{101, -30}, {106, -30}, {106, -5}, {120, -5}}, color = {0, 0, 127}));
      connect(division1.u2, numerical_limit.y) annotation(
        Line(points = {{78, 24}, {-8, 24}, {-8, -10}, {-59, -10}}, color = {0, 0, 127}));
      connect(division1.y, qppriority.Ip) annotation(
        Line(points = {{101, 30}, {106, 30}, {106, 5}, {120, 5}}, color = {0, 0, 127}));
      connect(freq, add2.u1) annotation(
        Line(points = {{-200, 150}, {-142, 150}}, color = {0, 0, 127}));
      connect(deadZone.y, frequency_droop.u) annotation(
        Line(points = {{-79, 144}, {-62, 144}}, color = {0, 0, 127}));
      connect(freq_ref.y, add2.u2) annotation(
        Line(points = {{-171, 110}, {-160, 110}, {-160, 138}, {-142, 138}}, color = {0, 0, 127}));
      connect(add2.y, deadZone.u) annotation(
        Line(points = {{-119, 144}, {-102, 144}}, color = {0, 0, 127}));
      connect(add.y, deadband_voltage.u) annotation(
        Line(points = {{-99, -70}, {-82, -70}}, color = {0, 0, 127}));
      connect(voltage_droop.u, deadband_voltage.y) annotation(
        Line(points = {{-42, -70}, {-59, -70}}, color = {0, 0, 127}));
      connect(add1.y, limiter.u) annotation(
        Line(points = {{25, -70}, {38, -70}}, color = {0, 0, 127}));
      connect(voltage_droop.y, add1.u1) annotation(
        Line(points = {{-19, -70}, {-10, -70}, {-10, -69}, {2, -69}, {2, -64}}, color = {0, 0, 127}));
      connect(reactive_power_reference.y, add1.u2) annotation(
        Line(points = {{-59, -110}, {-10, -110}, {-10, -95}, {2, -95}, {2, -76}}, color = {0, 0, 127}));
      connect(limiter.y, division.u1) annotation(
        Line(points = {{61, -70}, {62.5, -70}, {62.5, -24}, {78, -24}}, color = {0, 0, 127}));
      connect(QCurrentController.y, Iq) annotation(
        Line(points = {{181, -70}, {210, -70}}, color = {0, 0, 127}));
      connect(PCurrentController.y, Ip) annotation(
        Line(points = {{181, 90}, {210, 90}}, color = {0, 0, 127}));
      connect(active_power_reference.y, add4.u2) annotation(
        Line(points = {{-138, 30}, {-80, 30}, {-80, 44}, {-62, 44}, {-62, 44}}, color = {0, 0, 127}));
      connect(frequency_droop.y, add4.u1) annotation(
        Line(points = {{-38, 144}, {-34, 144}, {-34, 104}, {-80, 104}, {-80, 56}, {-62, 56}, {-62, 56}}, color = {0, 0, 127}));
      connect(add4.y, division1.u1) annotation(
        Line(points = {{-38, 50}, {52, 50}, {52, 36}, {78, 36}, {78, 36}}, color = {0, 0, 127}));
      connect(qppriority.Ipcmd, PCurrentController.u) annotation(
        Line(points = {{142, 6}, {148, 6}, {148, 90}, {158, 90}, {158, 90}}, color = {0, 0, 127}));
  connect(qppriority.Iqcmd, QCurrentController.u) annotation(
        Line(points = {{142, -4}, {150, -4}, {150, -70}, {158, -70}, {158, -70}}, color = {0, 0, 127}));
    protected
  annotation(
        Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.05), graphics = {Text(origin = {-186, 179}, lineColor = {255, 0, 0}, extent = {{-8, 3}, {76, -9}}, textString = "Frequency filtering has to be done outside of this block", horizontalAlignment = TextAlignment.Left), Rectangle(origin = {-67, 141}, lineColor = {0, 170, 0}, pattern = LinePattern.Dash, lineThickness = 1, extent = {{-85, 21}, {51, -45}}), Text(origin = {-186, 179}, lineColor = {255, 0, 0}, extent = {{-8, 3}, {76, -9}}, textString = "Frequency filtering has to be done outside of this block", horizontalAlignment = TextAlignment.Left), Text(origin = {-186, 179}, lineColor = {255, 0, 0}, extent = {{-8, 3}, {76, -9}}, textString = "Frequency filtering has to be done outside of this block", horizontalAlignment = TextAlignment.Left), Text(origin = {-92, 171}, lineColor = {0, 170, 0}, lineThickness = 1, extent = {{-8, 3}, {76, -9}}, textString = "Underfrequency Droop Control", horizontalAlignment = TextAlignment.Left), Rectangle(origin = {-67, 141}, lineColor = {0, 170, 0}, pattern = LinePattern.Dash, lineThickness = 1, extent = {{-85, 21}, {51, -45}}), Rectangle(origin = {-5, -71}, lineColor = {0, 170, 0}, pattern = LinePattern.Dash, lineThickness = 1, extent = {{-85, 21}, {79, -57}}), Text(origin = {-120, -41}, lineColor = {0, 170, 0}, lineThickness = 1, extent = {{30, -1}, {76, -9}}, textString = "Volt/Var Control", horizontalAlignment = TextAlignment.Left)}),
        Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.05), graphics = {Rectangle(origin = {-52, 50},fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-150, 150}, {252, -250}}), Text(origin = {26, 194}, extent = {{-228, -34}, {174, 6}}, textString = "PVD1")}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    end PVD1;

    model QPPriority
    parameter Boolean PqFlag;
    parameter SI.PerUnit Imax;
    Modelica.Blocks.Interfaces.RealInput Ip annotation(
        Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Iq annotation(
        Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Iqcmd annotation(
        Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Ipcmd annotation(
        Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.VariableLimiter IpLimiter annotation(
        Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.VariableLimiter IqLimiter annotation(
        Placement(visible = true, transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Iqmin;
    Modelica.Blocks.Interfaces.RealOutput Iqmax;
    Modelica.Blocks.Interfaces.RealOutput Ipmin;
    Modelica.Blocks.Interfaces.RealOutput Ipmax;
    equation
    connect(IqLimiter.y, Iqcmd) annotation(
        Line(points = {{11, -50}, {110, -50}}, color = {0, 0, 127}));
    connect(IpLimiter.y, Ipcmd) annotation(
        Line(points = {{11, 50}, {110, 50}}, color = {0, 0, 127}));
    connect(Ip, IpLimiter.u) annotation(
        Line(points = {{-100, 50}, {-12, 50}}, color = {0, 0, 127}));
    connect(Iq, IqLimiter.u) annotation(
        Line(points = {{-100, -50}, {-12, -50}}, color = {0, 0, 127}));
    if PqFlag then
    Ipmax = Imax;
    Iqmax = sqrt(Imax^2 - Ipcmd^2);
    else
    Ipmax = sqrt(Imax^2 - Iqcmd^2);
    Iqmax = Imax;
    end if;
    Iqmin = -Iqmax;
    Ipmin = 0;
    connect(Ipmin, IpLimiter.limit2);
    connect(Ipmax, IpLimiter.limit1);
    connect(Iqmin, IqLimiter.limit2);
    connect(Iqmax, IqLimiter.limit1);
    annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {20, 100}, extent = {{-120, 0}, {80, -20}}, textString = "PQ Priority"), Text(origin = {44, 60}, extent = {{-120, 0}, {-78, -20}}, textString = "Ipref"), Text(origin = {44, -40}, extent = {{-120, 0}, {-78, -20}}, textString = "Iqref"), Text(origin = {172, 62}, extent = {{-120, 0}, {-78, -20}}, textString = "Ipcmd"), Text(origin = {172, -38}, extent = {{-120, 0}, {-78, -20}}, textString = "Iqcmd")}));end QPPriority;

    model VoltageTripping
    equation

    end VoltageTripping;

    model ElmPhi_pll
    parameter Boolean PLLEnable=false "Enable/disable PLL (PLL not implemented yet)";
    OpenIPSL.Interfaces.PwPin p annotation(
        Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput sinphi annotation(
        Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput cosphi annotation(
        Placement(visible = true, transformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    SI.PerUnit v;
    equation
    v = sqrt(p.vr^2+p.vi^2);
sinphi = p.vr/v;
    cosphi = p.vi/v;
    p.ii = 0;
    p.ir = 0;
    annotation(
        Diagram(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-15, 93}, extent = {{-85, 7}, {115, -13}}, textString = "ElmPhi_pll")}));end ElmPhi_pll;

    model GenerationTripping
    parameter Real Lv0;
    parameter Real Lv1;
    parameter Real Lv2;
    parameter Real Lv3;
    parameter Real recov;
    Modelica.Blocks.Interfaces.RealInput u annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput TrpLow annotation(
        Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput TrpHigh annotation(
        Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real umin(start=999);
    Real umax(start=-Modelica.Constants.inf);
    equation
// Tracking the minimum voltage
    if u < umin then 
      umin = u;
    end if;
    if umin < Lv0 then
    umin = Lv0;
    end if;
    if u < Lv0 then
     TrpLow = 0.0;
    elseif u < Lv1 then
      if (u <= umin) then
        TrpLow = (umin - Lv0) / (Lv1-Lv0);
      else
        TrpLow = ((umin - Lv0) + recov * (u - umin)) / (Lv1 - Lv0);
      end if;
    else
      if umin >= Lv1 then
        TrpLow = 1.0;
      else
        TrpLow = ((umin - Lv0) + recov * (Lv1 - umin)) / (Lv1 - Lv0);
      end if;
    end if;
    if (u > umax) then
      umax = u;
    end if; 
    if umax > Lv3 then 
    umax = Lv3;
    end if;
    if u > Lv3 then
      TrpHigh = 0;
    elseif u > Lv2 then
      if u >= umax then
        TrpHigh = (Lv3 - umax) / (Lv3 - Lv2);
      else
        TrpHigh = ((Lv3 - umax) + recov * (umax - u)) / (Lv3 - Lv2);   
      end if; 
    else
      if umax <= Lv2 then
      TrpHigh = 1.0;
      else
        TrpHigh = ((Lv3 - umax) + recov * (umax - Lv2)) / (Lv3 - Lv2);
      end if; 
    end if;
    
    
    annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {32, 93}, extent = {{-132, 7}, {68, -13}}, textString = "Generation Tripping"), Text(origin = {144, 53}, extent = {{-132, 7}, {-44, -13}}, textString = "TripLow"), Text(origin = {144, -47}, extent = {{-132, 7}, {-44, -13}}, textString = "TripHigh"), Text(origin = {36, 3}, extent = {{-132, 7}, {-44, -13}}, textString = "Input")}));
        end GenerationTripping;
  end WECC;

  model SolarPlantPVD1
    extends OpenIPSL.Electrical.Essentials.pfComponent(final enabledisplayPF = false, final enablefn = true, final enableV_b = false, final enableangle_0 = true, final enablev_0 = true, final enableQ_0 = true, final enableP_0 = true, final enableS_b = true);
  OpenIPSL.Electrical.Solar.PowerFactory.ElmModels.ElmGenstat StaticGenerator(P_0 = P_0, Q_0 = Q_0)  annotation(
      Placement(visible = true, transformation(origin = {40, -2.88658e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OpenIPSL.Interfaces.PwPin p annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.ElmModels.StaVmeas staVmeas(Tfe = 3 / fn, fn = fn)  annotation(
      Placement(visible = true, transformation(origin = {-10, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.PVD1 controller(Imax = 1.1,PqFlag = true, Pref = P_0 / S_b, Qref = Q_0 / S_b, fn = 1, fr_recov = 0, u_0 = v_0,  vr_recov = 0)  annotation(
      Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.ElmPhi_pll pll annotation(
      Placement(visible = true, transformation(origin = {30, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(StaticGenerator.p, p) annotation(
      Line(points = {{60, 0}, {110, 0}}, color = {0, 0, 255}));
  connect(staVmeas.p, p) annotation(
      Line(points = {{2, 50}, {80, 50}, {80, 0}, {110, 0}, {110, 0}}, color = {0, 0, 255}));
  connect(controller.Iq, StaticGenerator.iq_ref) annotation(
      Line(points = {{-19.5, 5.5}, {0, 5.5}, {0, 6}, {20, 6}}, color = {0, 0, 127}));
  connect(staVmeas.u, controller.Vt) annotation(
      Line(points = {{-20, 56}, {-50, 56}, {-50, 16}, {-40, 16}, {-40, 17}}, color = {0, 0, 127}));
  connect(staVmeas.fe, controller.freq) annotation(
      Line(points = {{-20, 46}, {-46, 46}, {-46, 6}, {-40, 6}, {-40, 7}}, color = {0, 0, 127}));
  connect(controller.Ip, StaticGenerator.id_ref) annotation(
      Line(points = {{-19.5, 15.5}, {0, 15.5}, {0, 14}, {20, 14}}, color = {0, 0, 127}));
  connect(StaticGenerator.It, controller.It) annotation(
      Line(points = {{62, 14}, {70, 14}, {70, 24}, {-44, 24}, {-44, 13}, {-40, 13}}, color = {0, 0, 127}));
  connect(pll.p, p) annotation(
      Line(points = {{42, -50}, {80, -50}, {80, 0}, {104, 0}, {104, 0}, {110, 0}}, color = {0, 0, 255}));
  connect(pll.sinphi, StaticGenerator.cosref) annotation(
      Line(points = {{20, -44}, {6, -44}, {6, -4}, {20, -4}, {20, -4}}, color = {0, 0, 127}));
  connect(pll.cosphi, StaticGenerator.sinref) annotation(
      Line(points = {{20, -52}, {12, -52}, {12, -14}, {20, -14}, {20, -14}}, color = {0, 0, 127}));
  annotation(
      Icon(graphics = {Ellipse(origin = {50, -48}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-150, 148}, {50, -52}}, endAngle = 360), Line(origin = {-0.22, 25.23}, points = {{0, -83}, {0, 25}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10)}));end SolarPlantPVD1;
end PowerFactory;
