within OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels;
model ElmGenstat
  extends OpenIPSL.Electrical.Essentials.pfComponent(final enabledisplayPF = false, final enablefn = true, final enableV_b = false, final enableangle_0 = true, final enablev_0 = true, final enableQ_0 = true, final enableP_0 = true, final enableS_b = true);
  //Real anglev;
  //Real anglei;
  //Real Vt;
  Real Q;
  Real P;
  Modelica.Blocks.Interfaces.RealInput id_ref annotation (
    Placement(visible = true, transformation(origin = {-108, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iq_ref annotation (
    Placement(visible = true, transformation(origin = {-108, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput sinref annotation (
    Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput cosref annotation (
    Placement(visible = true, transformation(origin = {-108, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealOutput It annotation (
    Placement(visible = true, transformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  p.ir = -(id_ref * cosref - iq_ref * sinref);
  p.ii = -(id_ref * sinref + iq_ref * cosref);
  -P = p.vr * p.ir + p.vi * p.ii;
  -Q = p.vi * p.ir - p.vr * p.ii;
  //Vt = sqrt(p.vr ^ 2 + p.vi ^ 2);
  //anglev = atan2(p.vi, p.vr);
  It = sqrt(p.ii ^ 2 + p.ir ^ 2);
  //anglei = atan2(p.ii, p.ir);
  annotation (
    Icon(graphics={  Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(origin = {-69.7, 70.01},
            fillPattern =                                                                                                                                                      FillPattern.Solid, extent = {{-12.3, -8.18}, {12.3, 8.18}}, textString = "id_ref", fontName = "Arial"), Text(origin = {-63.7, 29.82},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-12.3, -8.18}, {12.3, 8.18}}, textString = "iq_ref", fontName = "Arial"), Text(origin = {24.07, -72.08},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-124.07, -27.92}, {76.07, -8.08}}, textString = "ElmStatgen", fontName = "Arial"), Text(origin = {-63.7, -72.18},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-12.3, -8.18}, {14.3, 8.18}}, textString = "cosref", fontName = "Arial"), Text(origin = {-63.7, -20.18},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-12.3, -8.18}, {12.3, 8.18}}, textString = "sinref", fontName = "Arial"), Ellipse(origin = {50, -48}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-100, 100}, {-2, -2}}, endAngle = 360), Line(origin = {-0.000710326, 0.400639}, points = {{0, -25}, {0, 25}}, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10)}, coordinateSystem(initialScale = 0.1)),
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
