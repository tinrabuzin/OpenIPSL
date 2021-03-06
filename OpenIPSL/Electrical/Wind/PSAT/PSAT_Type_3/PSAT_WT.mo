within OpenIPSL.Electrical.Wind.PSAT.PSAT_Type_3;
model PSAT_WT "Wind Turbine Doubly Fed Induction Generator"
  import Modelica.Constants.pi;
  ElecDynBlk elecDyn(
    Sbase=S_b,
    Vbus0=V_0,
    angle_0=angle_0,
    Pc=P_0,
    Qc=Q_0,
    omega_m0=omega_m0,
    Pnom=Pnom,
    Vbase=V_b,
    freq=fn,
    Rs=Rs,
    Xs=Xs,
    Rr=Rr,
    Xr=Xr,
    Xm=Xm,
    Hm=Hm,
    x1=x1,
    x2=x2,
    i2Hm=i2Hm,
    wbase=wbase,
    k=k,
    poles=poles,
    ids0=ids0,
    iqs0=iqs0,
    idr0=idr0,
    iqr0=iqr0,
    vds0=vds0,
    vqs0=vqs0,
    vdr0=vdr0,
    vqr0=vqr0,
    Kv=Kv,
    Te=Te,
    idr_max=idr_max,
    idr_min=idr_min,
    iqr_max=iqr_max,
    iqr_min=iqr_min) annotation (Placement(transformation(
        origin={-46.9875,-45.0},
        extent={{-10.0,-10.0},{10.0,10.0}})));
  ElecBlk elecCircuit(
    Sbase=S_b,
    Vbus0=V_0,
    angle_0=angle_0,
    Pc=P_0,
    Qc=Q_0,
    omega_m0=omega_m0,
    Pnom=Pnom,
    Vbase=V_b,
    freq=fn,
    Rs=Rs,
    Xs=Xs,
    Rr=Rr,
    Xr=Xr,
    Xm=Xm,
    Hm=Hm,
    x1=x1,
    i2Hm=i2Hm,
    wbase=wbase,
    k=k,
    poles=poles,
    ids0=ids0,
    iqs0=iqs0,
    idr0=idr0,
    iqr0=iqr0,
    vds0=vds0,
    vqs0=vqs0,
    vdr0=vdr0,
    vqr0=vqr0) annotation (Placement(transformation(
        origin={43.0125,-50.0},
        extent={{-10.0,-10.0},{10.0,10.0}})));
  WindBlk windBlk1(
    vw_base=vw_base,
    rho=rho,
    Sbase=S_b,
    ngb=ngb,
    poles=poles,
    freq=fn,
    wbase=wbase,
    l=l) annotation (Placement(transformation(
        origin={15.4451,-15.0},
        extent={{-10.0,-10.0},{10.0,10.0}})));
  MechaBlk mechaBlk1(
    Sbase=S_b,
    Pnom=Pnom,
    Hm=Hm,
    Pc=P_0) annotation (Placement(transformation(
        origin={70.3869,-20.0},
        extent={{-10.0,-10.0},{10.0,10.0}})));
  PitchControl pitchControl1(
    Kp=Kp,
    Tp=Tp,
    theta_p0=theta_p0,
    theta_p_max=theta_max,
    theta_p_min=theta_min) annotation (Placement(transformation(
        origin={-46.9875,-15.0},
        extent={{-10.0,-10.0},{10.0,10.0}})));
  Modelica.Blocks.Interfaces.RealInput Wind_Speed annotation (Placement(
      transformation(
        origin={-111.9875,-2.3928},
        extent={{-20.0,-20.0},{20.0,20.0}}),
      iconTransformation(
        origin={0.0,77.9903},
        extent={{-20.0,-20.0},{20.0,20.0}},
        rotation=-90)));
  OpenIPSL.Interfaces.PwPin pin annotation (Placement(
      transformation(
        origin={-101.9875,-70.0},
        extent={{-10.0,-10.0},{10.0,10.0}}),
      iconTransformation(
        origin={-110.0,0.0},
        extent={{-10.0,-10.0},{10.0,10.0}})));
  parameter Types.PerUnit V_0=1 "Voltage magnitude"
    annotation (Dialog(group="Power flow data"));
  parameter Types.Angle angle_0=-0.00243 "Voltage angle"
    annotation (Dialog(group="Power flow data"));
  parameter Types.PerUnit P_0=0.0160000000000082 "Active power"
    annotation (Dialog(group="Power flow data"));
  parameter Types.PerUnit Q_0=0.030527374471207 "Reactive power"
    annotation (Dialog(group="Power flow data"));
  parameter Types.ApparentPower S_b=100000000 "System base power"
    annotation (Dialog(group="Power flow data"));
  parameter Types.Voltage V_b=400e3 "Voltage rating"
    annotation (Dialog(group="Power flow data"));
  parameter Types.ApparentPower Pnom=10000000 "Nominal Power";
  parameter Types.Frequency fn=50 "Frequency rating";
  parameter SI.Density rho=1.225 "Air Density";
  parameter SI.Velocity vw_base=15 "Nominal wind speed";
  parameter Types.PerUnit Rs_machine=0.01 "Stator Resistance";
  parameter Types.PerUnit Xs_machine=0.1 "Stator Reactance";
  parameter Types.PerUnit Rr_machine=0.01 "Rotor Resitance";
  parameter Types.PerUnit Xr_machine=0.08 "Rotor Reactance";
  parameter Types.PerUnit Xm_machine=3 "Magnetisation reactance";
  parameter Types.Time Hm_machine=3 "Inertia";
  parameter Real Kp=10 "Pitch control gain";
  parameter Types.Time Tp=3 "Pitch control time constant";
  parameter Real Kv=10 "Voltage control gain";
  parameter Types.Time Te=0.01 "Power Control time constant";
  parameter SI.Length l=75 "Blade length";
  parameter Integer poles=2 "Number of poles-pair";
  parameter Integer nblades=3 "Number of blades";
  parameter Real ngb=0.01123596 "Gear box ratio";
  Types.PerUnit Vbus=elecCircuit.Vbus "Bus voltage magnitude";
  Types.Angle Anglebus=elecCircuit.Anglebus "Bus voltage angle";
  Types.PerUnit P=elecCircuit.p "Active power";
  Types.PerUnit Q=elecCircuit.q "Reactive power";
protected
  parameter Types.PerUnit Rs=Rs_machine*S_b/Pnom "stator Resistance (pu)";
  parameter Types.PerUnit Xs=Xs_machine*S_b/Pnom "stator Reactance (pu)";
  parameter Types.PerUnit Rr=Rr_machine*S_b/Pnom "Rotor Resitance (pu)";
  parameter Types.PerUnit Xr=Xr_machine*S_b/Pnom "rotor Reactance (pu)";
  parameter Types.PerUnit Xm=Xm_machine*S_b/Pnom "magnetisation reactance (pu)";
  parameter Types.Time Hm=Hm_machine*Pnom/S_b "inertia (pu)";
  parameter Types.PerUnit Pmax_machine=1 "Pmax (pu)";
  parameter Types.PerUnit Pmin_machine=0 "Pmin (pu)";
  parameter Types.PerUnit Qmax_machine=0.7 "Qmax (pu)";
  parameter Types.PerUnit Qmin_machine=-0.7 "Qmin (pu)";
  parameter Types.PerUnit Pmax=Pmax_machine*Pnom/S_b "Pmax (pu)";
  parameter Types.PerUnit Pmin=Pmin_machine*Pnom/S_b "Pmin (pu)";
  parameter Types.PerUnit Qmax=Qmax_machine*Pnom/S_b "Qmax (pu)";
  parameter Types.PerUnit Qmin=Qmin_machine*Pnom/S_b "Qmin (pu)";
  parameter Types.PerUnit x1=Xs + Xm;
  parameter Types.PerUnit x2=Xr + Xm;
  parameter Types.PerUnit iqr_max=-x1*Pmin/Xm;
  parameter Types.PerUnit iqr_min=-Pmax*x1/Xm;
  parameter Types.PerUnit idr_min=(-Qmax*x1/Xm) - x1/Xm^2;
  parameter Types.PerUnit idr_max=(-Qmin*x1/Xm) - x1/Xm^2;
  parameter Types.Angle theta_max=0.78539816339;
  parameter Types.Angle theta_min=0;
  parameter Types.PerUnit omega_m0=min(max(0.5*P_0*S_b/Pnom + 0.5, 0.5), 1);
  parameter Types.TimeAging i2Hm=1/(2*Hm);
  parameter SI.AngularVelocity wbase=2*Modelica.Constants.pi*fn/poles;
  parameter Real k=x1*Pnom/V_0/Xm/S_b "gain for iqr_off computation";
  parameter Types.Angle theta_p0=0;
  parameter Types.PerUnit ids0=((-vds0^2) + vds0*Xm*iqr0 - x1*Q_0)/(Rs*vds0 - x1*vqs0);
  parameter Types.PerUnit iqs0=((-vds0*vqs0) + vqs0*Xm*iqr0 - Rs*Q_0)/(Rs*vds0 - x1*vqs0);
  parameter Types.PerUnit idr0=-(vqs0 + Rs*iqs0 + x1*ids0)/Xm;
  parameter Types.PerUnit iqr0=-x1*Pnom*(2*omega_m0 - 1)/V_0/Xm/S_b/omega_m0;
  parameter Types.PerUnit vds0=-V_0*sin(angle_0);
  parameter Types.PerUnit vqs0=V_0*cos(angle_0);
  parameter Types.PerUnit vdr0=(-Rr*idr0) + (1 - omega_m0)*(x2*iqr0 + Xm*iqs0);
  parameter Types.PerUnit vqr0=(-Rr*iqr0) - (1 - omega_m0)*(x2*idr0 + Xm*ids0);
equation
  connect(pin, elecCircuit.pin) annotation (Line(
      origin={-5.4875,-55.7974},
      points={{-96.5,-14.2026},{48.5,-14.2026},{48.5,-5.2026}}));
  connect(mechaBlk1.omega_m, elecDyn.omega_m) annotation (Line(
      origin={40.3844,-34.0062},
      points={{38.0025,14.0062},{42.6281,14.0062},{42.6281,0.9937},{44.6156,
          0.9937},{37.6281,0.9937},{-100.3844,0.9937},{-100.3844,-15.9937},{-95.3719,
          -15.9938}},
      color={0,0,127}));
  connect(elecDyn.Vbus, elecCircuit.Vbus) annotation (Line(
      origin={-2.65,-55.6607},
      points={{-52.3375,15.6607},{-59.3375,15.6607},{-59.3375,-16.3215},{58.675,
          -16.3215},{58.675,0.6607},{53.6625,0.6607}},
      color={0,0,127}));
  connect(elecDyn.idr, elecCircuit.idr) annotation (Line(
      origin={14.0062,-41.6194},
      points={{-52.9937,1.6194},{15.9938,1.6194},{15.9938,-1.61938},{21.0063,-1.61938}},
      color={0,0,127}));

  connect(elecDyn.iqr, elecCircuit.iqr) annotation (Line(
      origin={-1.9875,-50.0},
      points={{-37.0,0.0},{37.0,0.0}},
      color={0,0,127}));
  connect(mechaBlk1.omega_m, elecCircuit.omega_m) annotation (Line(
      origin={59.8363,-27.8632},
      points={{18.5506,7.8632},{23.1762,7.8632},{23.1762,-5.2097},{-66.8238,-5.2097},
          {-66.8238,-29.1368},{-24.8238,-29.1368}},
      color={0,0,127}));
  connect(mechaBlk1.Tel, elecCircuit.Tel) annotation (Line(
      origin={56.3623,-35.0},
      points={{6.0246,10},{-0.3373,10},{-0.3373,-10},{-5.3498,-10}},
      color={0,0,127}));
  connect(pitchControl1.theta_p, windBlk1.theta_p) annotation (Line(
      origin={-6.6693,-15.1284},
      points={{-32.3182,0.1284},{9.1019,0.1284},{9.1019,-0.12848},{14.1144,-0.12848}},
      color={0,0,127}));

  connect(windBlk1.Tm, mechaBlk1.Tm) annotation (Line(
      origin={50.1452,-14.8679},
      points={{-26.7001,0.13217},{7.2292,0.13217},{7.2292,-0.1321},{12.2417,-0.1321}},
      color={0,0,127}));

  connect(mechaBlk1.omega_m, windBlk1.omega_m) annotation (Line(
      origin={42.916,-25.0816},
      points={{35.4709,5.0816},{40.4834,5.0816},{40.4834,-7.9309},{-40.4834,-7.9309},
          {-40.4834,2.84934},{-35.4709,2.84934}},
      color={0,0,127}));
  connect(Wind_Speed, windBlk1.vw) annotation (Line(
      origin={-24.9193,-5.1166},
      points={{-87.0682,2.7238},{27.3519,2.7238},{27.3519,-2.72393},{32.3644,-2.72393}},
      color={0,0,127}));

  connect(pitchControl1.omega_m, mechaBlk1.omega_m) annotation (Line(
      origin={25.5125,-22.0292},
      points={{-80.5,7.0292},{-85.5125,7.0292},{-85.5125,-11.0437},{57.5,-11.0437},
          {57.5,2.0292},{52.8744,2.0292}},
      color={0,0,127}));
  annotation (
    Icon(coordinateSystem(
        extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        grid={10,10}), graphics={Text(
          fillPattern=FillPattern.Solid,
          extent={{-55.0,-28.0231},{55.0,28.0231}},
          textString="Dfig",
          fontName="Arial"),Ellipse(
          fillColor={255,255,255},
          extent={{-100.0,-100.0},{100.0,100.0}})}),
    Diagram(coordinateSystem(
        extent={{-148.5,-105.0},{148.5,105.0}},
        preserveAspectRatio=true,
        grid={5,5})),
    Documentation(revisions="<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\"><tr>
<td><p>Reference</p></td>
<td><p>PSAT Manual 2.1.8</p></td>
</tr>
<tr>
<td><p>Last update</p></td>
<td><p>2015-07</p></td>
</tr>
<tr>
<td><p>Author</p></td>
<td><p><a href=\"https://github.com/MaximeBaudette\">@MaximeBaudette</a></p></td>
</tr>
<tr>
<td><p>Contact</p></td>
<td><p>see <a href=\"modelica://OpenIPSL.UsersGuide.Contact\">UsersGuide.Contact</a></p></td>
</tr>
</table>
</html>"));
end PSAT_WT;
