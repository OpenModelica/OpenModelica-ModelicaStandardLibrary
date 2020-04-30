within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples;
model LinearInductor "Linear inductor with ferromagnetic core"
  extends Modelica.Icons.Example;
  output SI.Current deviation = feedback.y "Deviation of transient and quasi-static current";
  FluxTubes.Basic.Ground ground_mQS annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource
    sourceQS(
    f=50,
    V=230,
  gamma(fixed=true),
  phi=1.5707963267949) "Voltage applied to inductor" annotation (Placement(
        transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor
    rQS(R_ref=7.5) "Inductor coil resistance" annotation (Placement(transformation(extent={{-40,-50},
            {-20,-30}})));
  FluxTubes.Basic.ElectroMagneticConverter coilQS(N=600) "Inductor coil" annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Basic.ConstantReluctance r_mLeakQS(R_m=1.2e6) "Constant leakage reluctance"
    annotation (Placement(transformation(
        origin={30,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Shapes.FixedShape.GenericFluxTube r_mAirParQS(
    mu_rConst=1,
    l=0.0001,
    area=0.025^2)
  "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
    annotation (Placement(transformation(extent={{46,-50},{66,-30}})));
  Shapes.FixedShape.GenericFluxTube r_mFeQS(
    mu_rConst=1000,
    l=4*0.065,
    area=0.025^2) "Reluctance of ferromagnetic inductor core"
    annotation (Placement(transformation(
        origin={80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));

  Magnetic.FluxTubes.Basic.Ground ground_m
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage source(
    f=50,
    phase=pi/2,
    V=230*sqrt(2)) "Voltage applied to inductor" annotation (Placement(
        transformation(
        origin={-80,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor r(R=7.5)
  "Inductor coil resistance"
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil(N=600, i(fixed=true))
    "Inductor coil"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Magnetic.FluxTubes.Basic.ConstantReluctance r_mLeak(R_m=1.2e6)
    "Constant leakage reluctance" annotation (Placement(transformation(
        origin={30,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube r_mAirPar(
    nonLinearPermeability=false,
    mu_rConst=1,
    l=0.0001,
    area=0.025^2)
    "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
    annotation (Placement(transformation(extent={{46,50},{66,70}})));
  Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube r_mFe(
    mu_rConst=1000,
    l=4*0.065,
    material=Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M350_50A(),

    B(start=0),
    nonLinearPermeability=false,
    area=0.025^2) "Reluctance of ferromagnetic inductor core" annotation (
      Placement(transformation(
        origin={80,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,10},{-70,30}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor
    currentSensorQS
    annotation (Placement(transformation(extent={{-70,-30},{-50,-50}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-40,-10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
Modelica.Blocks.Math.RootMeanSquare rootMeanSquare(f=50)
  annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
equation
  connect(coilQS.port_p, r_mLeakQS.port_p) annotation (Line(points={{10,-40},{10,-40},{30,-40}},
                          color={255,170,85}));
  connect(r_mLeakQS.port_p, r_mAirParQS.port_p)
    annotation (Line(points={{30,-40},{46,-40}}, color={255,170,85}));
  connect(r_mAirParQS.port_n, r_mFeQS.port_p)
    annotation (Line(points={{66,-40},{74,-40},{80,-40}}, color={255,170,85}));
  connect(r_mFeQS.port_n, r_mLeakQS.port_n) annotation (Line(points={{80,-60},{67.5,
          -60},{55,-60},{30,-60}}, color={255,170,85}));
  connect(r_mFeQS.port_n, coilQS.port_n) annotation (Line(points={{80,-60},{10,-60},{10,-60}},
                           color={255,170,85}));
  connect(ground_mQS.port, r_mFeQS.port_n) annotation (Line(
      points={{80,-70},{80,-60}},
      color={255,170,85}));
  connect(rQS.pin_n, coilQS.pin_p) annotation (Line(
      points={{-20,-40},{-10,-40},{-10,-40}},
      color={85,170,255}));
  connect(sourceQS.pin_n, coilQS.pin_n) annotation (Line(
      points={{-80,-60},{-10,-60},{-10,-60}},
      color={85,170,255}));
  connect(sourceQS.pin_n, groundQS.pin) annotation (Line(
      points={{-80,-60},{-80,-70}},
      color={85,170,255}));
  connect(r.n, coil.p)
    annotation (Line(points={{-20,60},{-10,60},{-10,60}}, color={0,0,255}));
  connect(source.n, coil.n)
    annotation (Line(points={{-80,40},{-10,40},{-10,40}}, color={0,0,255}));
  connect(coil.port_p, r_mLeak.port_p)
    annotation (Line(points={{10,60},{10,60},{30,60}},   color={255,170,85}));
  connect(r_mLeak.port_p, r_mAirPar.port_p)
    annotation (Line(points={{30,60},{46,60}}, color={255,170,85}));
  connect(r_mAirPar.port_n, r_mFe.port_p)
    annotation (Line(points={{66,60},{74,60},{80,60}}, color={255,170,85}));
  connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{80,40},{67.5,40},
          {55,40},{30,40}}, color={255,170,85}));
  connect(r_mFe.port_n, coil.port_n)
    annotation (Line(points={{80,40},{10,40},{10,40}},   color={255,170,85}));
  connect(ground.p, source.n) annotation (Line(
      points={{-80,30},{-80,40}},
      color={0,0,255}));
  connect(ground_m.port, r_mFe.port_n) annotation (Line(
      points={{80,30},{80,40}},
      color={255,170,85}));
  connect(sourceQS.pin_p, currentSensorQS.pin_p) annotation (Line(
      points={{-80,-40},{-70,-40}},
      color={85,170,255}));
  connect(currentSensorQS.pin_n, rQS.pin_p) annotation (Line(
      points={{-50,-40},{-40,-40}},
      color={85,170,255}));
  connect(currentSensorQS.i, complexToPolar.u) annotation (Line(
      points={{-60,-29},{-60,-10},{-52,-10}},
      color={85,170,255}));
  connect(source.p, currentSensor.p) annotation (Line(
      points={{-80,60},{-70,60}},
      color={0,0,255}));
  connect(currentSensor.n, r.p) annotation (Line(
      points={{-50,60},{-40,60}},
      color={0,0,255}));
connect(currentSensor.i, rootMeanSquare.u) annotation (Line(
    points={{-60,49},{-60,20},{-52,20}},
    color={0,0,127}));
connect(rootMeanSquare.y, feedback.u1) annotation (Line(
    points={{-29,20},{2,20}},
    color={0,0,127}));
connect(complexToPolar.len, feedback.u2) annotation (Line(
    points={{-28,-4},{10,-4},{10,12}},
    color={0,0,127}));
  annotation (experiment(
      StopTime=0.2,
      Tolerance=1e-07), Documentation(
        info="<html>
<p>
This model compares a transient-linear magnetic circuit with a quasi-static magnetic circuit. A sinusoidal voltage is applied to an inductor with a closed ferromagnetic core of rectangular shape.
</p>

<p>Compare the following quantities</p>
<ul>
<li>Sinusoidal supply voltage<br>
    <code>source.v | sourceQS.v.re|im</code></li>
<li>Non-linear transient current due to saturation and equivalent quasi-static current<br>
    <code>currentSensor.i | currentSensorQS.i.re|im</code></li>
<li>Difference between RMS fundamental wave of transient current and the RMS quasi-static current<br>
    <code>feedback.y</code></li>
<li>Relative permeability of iron core of transient and quasi-static circuit<br>
    <code>r_mFe.mu_rConst | r_mFeQS.mu_rConst</code></li>
</ul>
</html>"));
end LinearInductor;
