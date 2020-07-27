within OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels;
model StaVmeas
  parameter Real Tfe = 3 / 50;
  parameter Real fn = 50;
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u annotation (
    Placement(visible = true, transformation(origin = {118, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput fe annotation (
    Placement(visible = true, transformation(origin = {108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real cosphi;
  Real sinphi;
initial equation
  cosphi = p.vr / sqrt(p.vr ^ 2 + p.vi ^ 2);
  sinphi = p.vi / sqrt(p.vr ^ 2 + p.vi ^ 2);
equation
  u = sqrt(p.vr ^ 2 + p.vi ^ 2);
  der(cosphi) = (p.vr / u - cosphi) / Tfe;
  der(sinphi) = (p.vi / u - sinphi) / Tfe;
  if abs(cosphi) > abs(sinphi) then
    fe = 1 + der(sinphi) / cosphi / (2 * Modelica.Constants.pi * fn);
  else
    fe = 1 + der(cosphi) / sinphi / (2 * Modelica.Constants.pi * fn);
  end if;
  p.ii = 0;
  p.ir = 0;
  annotation (
    Icon(graphics={  Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 90}, extent = {{-100, 10}, {100, -10}}, textString = "StaVmeas"), Text(origin = {0, 50}, extent = {{62, 8}, {100, -10}}, textString = "u"), Text(origin = {0, -50}, extent = {{62, 8}, {100, -10}}, textString = "fe")}, coordinateSystem(initialScale = 0.1)));
end StaVmeas;
