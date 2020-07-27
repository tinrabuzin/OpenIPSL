within OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels;
model ElmPhi_pll
  parameter Boolean PLLEnable = false "Enable/disable PLL (PLL not implemented yet)";
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput sinphi annotation (
    Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput cosphi annotation (
    Placement(visible = true, transformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SI.PerUnit v;
equation
  v = sqrt(p.vr ^ 2 + p.vi ^ 2);
  sinphi = p.vr / v;
  cosphi = p.vi / v;
  p.ii = 0;
  p.ir = 0;
  annotation (
    Diagram(coordinateSystem(initialScale = 0.1)),
    Icon(graphics={  Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 90}, extent = {{-100, 10}, {100, -10}}, textString = "ElmPhi_pll")}));
end ElmPhi_pll;
