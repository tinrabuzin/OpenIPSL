within OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels;
model ElmVac2
  import SI = Modelica.SIunits;
  import C = Modelica.Constants;
  extends OpenIPSL.Electrical.Essentials.pfComponent(
    final enabledisplayPF=false,
    final enablefn=false,
    final enableV_b=false,
    final enableangle_0=true,
    final enablev_0=true,
    final enableQ_0=true,
    final enableP_0=true,
    final enableS_b=true);
  Real P;
  Real Q;
  SI.Angle phiu;
  Modelica.Blocks.Interfaces.RealInput f0 annotation (
    Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput v(start=v_0, fixed=true) annotation (
    Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real vd;
  Real vq;
  Modelica.Blocks.Interfaces.RealOutput delta annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
phiu = angle_0rad;
equation
  der(phiu) = 2*fn*C.pi*(f0-fn/50);
  p.vr = v*cos(phiu);
  p.vi = v*sin(phiu);
  //[p.vr; p.vi] = v*[cos(phiu); sin(phiu)];
  -P = p.vr * p.ir + p.vi * p.ii;
  -Q = p.vi * p.ir - p.vr * p.ii;
  [vd;vq] = [cos(phiu), sin(phiu); -sin(phiu), cos(phiu)]*[p.vr; p.vi];
  delta = phiu;
  
annotation (
    Icon(graphics={  Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Line(origin = {-5.53254, -0.428994}, points = {{-40, 0}, {-20, 20}, {20, -20}, {40, 0}, {40, 0}})}));
end ElmVac2;