within OpenIPSL.Electrical.Solar.PowerFactory.DigSILENT.Auxiliary;

model ActivePowerController
  parameter Real K = 0.005 "Gain of the PI-Controller";
  parameter SI.Time T=0.03 "Integration Time Constant of the PI controller";
  parameter Real yo_min "Minimum d-axis current";
  parameter Real yo_max "Maximum d-axis current";
  parameter SI.PerUnit id0 "Initial d-axis current";
  Modelica.Blocks.Interfaces.RealInput yi annotation(
    Placement(visible = true, transformation(origin = {-160, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput yo annotation(
    Placement(visible = true, transformation(origin = {170, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput pred annotation(
    Placement(visible = true, transformation(origin = {-160, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimIntegrator I(initType = Modelica.Blocks.Types.Init.InitialOutput,k = K / T, limitsAtInit = false,outMax = yo_max, outMin = yo_min, y_start = id0) if with_I  annotation(
    Placement(visible = true, transformation(origin = {-88, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant disable(k = 0) if not with_I annotation(
    Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {10, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain P(k = K)  annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator tracker(initType = Modelica.Blocks.Types.Init.InitialOutput, k = 1 / 0.1, y_start = id0)  annotation(
    Placement(visible = true, transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = yo_max, uMin = yo_min)  annotation(
    Placement(visible = true, transformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = yo_max, uMin = yo_min) annotation(
    Placement(visible = true, transformation(origin = {44, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//protected
  Modelica.Blocks.Interfaces.RealOutput yo1 annotation(
    Placement(visible = true, transformation(origin = {78, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {88, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput yo2 annotation(
    Placement(visible = true, transformation(origin = {134, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {126, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput x annotation(
    Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {4, -106}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Boolean with_I = if T > 0 then true else false;
equation
  yo = if pred < 1 then min(yo1,yo2) else yo1;
  if pred < 1 then
    tracker.u = feedback.y;
  else
    tracker.u = 0;
  end if;
  connect(P.y, add.u1) annotation(
    Line(points = {{-19, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(I.u, yi) annotation(
    Line(points = {{-100, -20}, {-144, -20}, {-144, 0}, {-160, 0}}, color = {0, 0, 127}));
  connect(yi, P.u) annotation(
    Line(points = {{-160, 0}, {-42, 0}}, color = {0, 0, 127}));
  connect(I.y, x) annotation(
    Line(points = {{-77, -20}, {-53, -20}, {-53, -40}, {-41, -40}}, color = {0, 0, 127}));
  connect(disable.y, x) annotation(
    Line(points = {{-79, -60}, {-53, -60}, {-53, -40}, {-41, -40}}, color = {0, 0, 127}));
  connect(feedback.u2, tracker.y) annotation(
    Line(points = {{-30, 62}, {-30, 62}, {-30, 50}, {32, 50}, {32, 70}, {22, 70}, {22, 70}}, color = {0, 0, 127}));
  connect(product.y, limiter.u) annotation(
    Line(points = {{71, 70}, {87, 70}, {87, 70}, {87, 70}}, color = {0, 0, 127}));
  connect(product.u1, tracker.y) annotation(
    Line(points = {{48, 76}, {32, 76}, {32, 70}, {22, 70}, {22, 70}}, color = {0, 0, 127}));
  connect(pred, product.u2) annotation(
    Line(points = {{-160, 70}, {-60, 70}, {-60, 40}, {40, 40}, {40, 64}, {48, 64}, {48, 64}}, color = {0, 0, 127}));
  connect(limiter.y, yo2) annotation(
    Line(points = {{112, 70}, {128, 70}, {128, 70}, {134, 70}}, color = {0, 0, 127}));
  connect(x, add.u2) annotation(
    Line(points = {{-40, -40}, {-14, -40}, {-14, -12}, {-2, -12}, {-2, -12}}, color = {0, 0, 127}));
  connect(feedback.u1, yo1) annotation(
    Line(points = {{-38, 70}, {-48, 70}, {-48, 20}, {72, 20}, {72, -6}, {78, -6}}, color = {0, 0, 127}));
  connect(limiter1.u, add.y) annotation(
    Line(points = {{32, -6}, {20, -6}, {20, -6}, {22, -6}}, color = {0, 0, 127}));
  connect(yo1, limiter1.y) annotation(
    Line(points = {{78, -6}, {56, -6}, {56, -6}, {56, -6}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-160, -160}, {160, 160}}), graphics = {Rectangle(origin = {24, 67}, pattern = LinePattern.Dash, extent = {{-94, 39}, {94, -39}}), Text(origin = {-27, 113}, extent = {{-47, 7}, {47, -7}}, textString = "Tracking yo1", horizontalAlignment = TextAlignment.Left), Line(origin = {-12, 70}, points = {{-6, 0}, {6, 0}, {6, 0}}, color = {255, 0, 0})}),
    Icon(graphics = {Rectangle( lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Line(origin = {50.106, -52.0451}, points = {{-80, -40}, {-80, -20}, {-6, 30}}, color = {0, 0, 127}), Polygon(origin = {50, -84}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}), Line(origin = {50.175, -93.8248}, points = {{-80, 78}, {-80, 0}}, color = {192, 192, 192}), Line(origin = {40.2612, -7.74434}, points = {{-80, -80}, {30, -80}}, color = {192, 192, 192}), Polygon(origin = {2, -8}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}), Text(origin = {18, -50.9032}, lineColor = {192, 192, 192}, extent = {{0, 2.90323}, {34, -27.0968}}, textString = "PI"), Text(origin = {6, 89}, extent = {{-56, 9}, {56, -9}}, textString = "Active Power Control"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "pred"), Text(origin = {-58, 2}, extent = {{-30, 10}, {30, -10}}, textString = "yi"), Text(origin = {82, 2}, extent = {{-30, 10}, {30, -10}}, textString = "yo")}));
end ActivePowerController;
