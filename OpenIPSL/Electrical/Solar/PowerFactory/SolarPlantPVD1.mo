within OpenIPSL.Electrical.Solar.PowerFactory;
model SolarPlantPVD1
  extends OpenIPSL.Electrical.Essentials.pfComponent(final enabledisplayPF = false, final enablefn = true, final enableV_b = false, final enableangle_0 = true, final enablev_0 = true, final enableQ_0 = true, final enableP_0 = true, final enableS_b = true);
  OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels.ElmGenstat StaticGenerator(P_0 = P_0, Q_0 = Q_0) annotation (
    Placement(visible = true, transformation(origin = {40, -2.88658e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels.StaVmeas measurements(Tfe = 3 / fn, fn = 50) annotation (
    Placement(visible = true, transformation(origin = {-10, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.PVD1 controller(Ft0 = 0.998, Ft1 = 0.999,Imax = 1.1, PqFlag = true, Pref = P_0 / S_b, Qref = Q_0 / S_b, fn = 1, fr_recov = 1, u_0 = v_0, vr_recov = 0) annotation (
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Solar.PowerFactory.GeneralModels.ElmPhi_pll
    angle_estimation annotation (Placement(visible=true, transformation(
        origin={30,-50},
        extent={{10,-10},{-10,10}},
        rotation=0)));
equation
connect(measurements.u, controller.Vt) annotation (
    Line(points = {{-20, 56}, {-46, 56}, {-46, 18}, {-40, 18}, {-40, 18}}, color = {0, 0, 127}));
connect(measurements.fe, controller.freq) annotation (
    Line(points = {{-20, 46}, {-56, 46}, {-56, 6}, {-40, 6}, {-40, 8}}, color = {0, 0, 127}));
  connect(controller.It, StaticGenerator.It) annotation (
    Line(points = {{-40, 14}, {-48, 14}, {-48, 24}, {68, 24}, {68, 14}, {62, 14}, {62, 14}}, color = {0, 0, 127}));
  connect(controller.Ip, StaticGenerator.id_ref) annotation (
    Line(points = {{-20, 16}, {20, 16}, {20, 14}, {20, 14}}, color = {0, 0, 127}));
  connect(controller.Iq, StaticGenerator.iq_ref) annotation (
    Line(points = {{-20, 6}, {20, 6}, {20, 6}, {20, 6}}, color = {0, 0, 127}));
connect(angle_estimation.sinphi, StaticGenerator.cosref) annotation (
    Line(points = {{20, -44}, {6, -44}, {6, -4}, {20, -4}, {20, -4}}, color = {0, 0, 127}));
connect(angle_estimation.cosphi, StaticGenerator.sinref) annotation (
    Line(points = {{20, -52}, {12, -52}, {12, -14}, {20, -14}, {20, -14}}, color = {0, 0, 127}));
  connect(StaticGenerator.p, p) annotation (
    Line(points = {{60, 0}, {106, 0}, {106, 0}, {110, 0}}, color = {0, 0, 255}));
connect(angle_estimation.p, p) annotation (
    Line(points = {{42, -50}, {80, -50}, {80, -2}, {110, -2}, {110, 0}}, color = {0, 0, 255}));
connect(measurements.p, p) annotation (
    Line(points = {{2, 50}, {80, 50}, {80, 6}, {110, 6}, {110, 0}}, color = {0, 0, 255}));
  annotation (
    Icon(graphics={  Ellipse(origin = {50, -48}, fillColor = {255, 255, 255},
            fillPattern =                                                                   FillPattern.Solid, extent = {{-150, 148}, {50, -52}}, endAngle = 360), Line(origin = {-0.0673837, 60.7896}, points = {{0, -83}, {0, 25}}, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10), Text(origin = {-1, -52}, extent = {{-65, 12}, {65, -12}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end SolarPlantPVD1;