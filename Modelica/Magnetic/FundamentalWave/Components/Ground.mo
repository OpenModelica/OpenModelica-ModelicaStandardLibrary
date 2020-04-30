within Modelica.Magnetic.FundamentalWave.Components;
model Ground "Magnetic ground"
  Interfaces.PositiveMagneticPort port_p "Complex magnetic port"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  port_p.V_m = Complex(0, 0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{0,100},{0,50}}, color={255,128,0}),
        Line(points={{-60,50},{60,50}}, color={255,128,0}),
        Line(points={{-40,30},{40,30}}, color={255,128,0}),
        Line(points={{-20,10},{20,10}}, color={255,128,0}),
        Text(
          extent={{-150,-10},{150,-50}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>

<p>
Grounding of the complex magnetic potential. Each magnetic circuit has to be grounded at least one point of the circuit.
</p>

</html>"));
end Ground;
