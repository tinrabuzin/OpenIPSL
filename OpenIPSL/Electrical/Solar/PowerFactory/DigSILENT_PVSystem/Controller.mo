within OpenIPSL.Electrical.Solar.PowerFactory.DigSILENT_PVSystem;
model Controller
parameter Real Kp=0.005 "Gain, Active PI-Controller";
parameter SI.Time Tip=0.03 "Integration Time Constant, Active PI-Ctrl.";
parameter SI.Time Tr=0.001 "Measurement delay";
parameter SI.Time Tmpp=5 "Time-delay MPP-Tracking";
parameter SI.PerUnit Deadband=0.1 "Deadband for Dynamic AC Voltage Support";
parameter Real K_FRT=2 "Gain for Dynamic AC Voltage Support";
// choice variables
parameter SI.PerUnit id_min=0 "Min. Active Current Limit";
parameter SI.Voltage U_min=200 "Minimal allowed DC Voltage";
parameter SI.PerUnit iq_min=-1 "Min. Reactive Current Limit";
parameter SI.PerUnit id_max=1 "Max. Active Current Limit";
parameter SI.PerUnit iq_max=1 "Max. Reactive Current Limit";
parameter SI.PerUnit maxAbsCur=1 "Max. allowed absolute current";
parameter SI.PerUnit maxIq=1 "Max. absolute reactive current in normal operation";

  Modelica.Blocks.Interfaces.RealInput pred annotation (
    Placement(visible = true, transformation(origin = {-200, 170}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-200, 140}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vdcref annotation (
    Placement(visible = true, transformation(origin = {-200, 130}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-200, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vdcin annotation (
    Placement(visible = true, transformation(origin = {-200, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-200, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput uac annotation (
    Placement(visible = true, transformation(origin = {-200, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-200, -140}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iq_ref annotation (
    Placement(visible = true, transformation(origin = {210, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput id_ref annotation (
    Placement(visible = true, transformation(origin = {210, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder delay_mpp(T = Tmpp, k = 1)  annotation (
    Placement(visible = true, transformation(origin = {-150, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter dc_limit(limitsAtInit = true, uMax = Modelica.Constants.inf, uMin = U_min)  annotation (
    Placement(visible = true, transformation(origin = {-110, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder measurement_delay(T = Tr, k = 1) annotation (
    Placement(visible = true, transformation(origin = {-30, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder measurement_delay2(T = Tr, k = 1) annotation (
    Placement(visible = true, transformation(origin = {-150, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation (
    Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant ac_reference(k = uac0)  annotation (
    Placement(visible = true, transformation(origin = {-150, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(delay_mpp.u, vdcref) annotation (
    Line(points = {{-162, 130}, {-200, 130}}, color = {0, 0, 127}));
  connect(dc_limit.u, delay_mpp.y) annotation (
    Line(points = {{-122, 130}, {-138, 130}, {-138, 130}, {-138, 130}}, color = {0, 0, 127}));
  connect(feedback.u1, vdcin) annotation (
    Line(points = {{-78, 90}, {-186, 90}, {-186, 90}, {-200, 90}}, color = {0, 0, 127}));
  connect(dc_limit.y, feedback.u2) annotation (
    Line(points = {{-98, 130}, {-70, 130}, {-70, 98}, {-70, 98}}, color = {0, 0, 127}));
  connect(measurement_delay.u, feedback.y) annotation (
    Line(points = {{-42, 90}, {-62, 90}, {-62, 90}, {-60, 90}}, color = {0, 0, 127}));
  connect(measurement_delay2.u, uac) annotation (
    Line(points = {{-162, 30}, {-184, 30}, {-184, 30}, {-200, 30}}, color = {0, 0, 127}));
  connect(measurement_delay2.y, feedback1.u1) annotation (
    Line(points = {{-138, 30}, {-118, 30}, {-118, 30}, {-118, 30}}, color = {0, 0, 127}));
  connect(ac_reference.y, feedback1.u2) annotation (
    Line(points = {{-138, -10}, {-110, -10}, {-110, 22}}, color = {0, 0, 127}));

annotation (
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.05)),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.05), graphics={  Rectangle(fillColor = {255, 255, 255},
            fillPattern =                                                                                                                             FillPattern.Solid, extent = {{-200, 200}, {200, -200}})}));
end Controller;
