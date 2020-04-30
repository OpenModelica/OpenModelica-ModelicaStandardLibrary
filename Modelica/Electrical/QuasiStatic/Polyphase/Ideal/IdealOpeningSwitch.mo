within Modelica.Electrical.QuasiStatic.Polyphase.Ideal;
model IdealOpeningSwitch "Polyphase ideal opener"
  extends QuasiStatic.Polyphase.Interfaces.TwoPlug;
  parameter SI.Resistance Ron[m](final min=zeros(m), start=
        fill(1e-5, m)) "Closed switch resistance";
  parameter SI.Conductance Goff[m](final min=zeros(m), start=
        fill(1e-5, m)) "Opened switch conductance";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, final T=fill(293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput control[m]
    "true => switch open, false => p--n connected" annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  QuasiStatic.SinglePhase.Ideal.IdealOpeningSwitch idealOpeningSwitch[m](
    final Ron=Ron,
    final Goff=Goff,
    each final useHeatPort=useHeatPort)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(control, idealOpeningSwitch.control)
    annotation (Line(points={{0,120},{0,46},{0,12}}, color={255,0,255}));
  connect(idealOpeningSwitch.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(idealOpeningSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
      points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(plugToPins_p.pin_p, idealOpeningSwitch.pin_p) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                                   Line(points={{-90,0},{-44,0}}, color={85,170,255}),
          Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,
          255}),Line(points={{-37,2},{40,40}}, color={85,170,255}),
                                                      Line(points={{40,0},{
          90,0}}, color={85,170,255}),
                               Line(points={{40,20},{40,0}}, color={85,170,255}),
        Text(
          extent={{-150,90},{150,50}},
              textString="%name",
          textColor={0,0,255}),
                Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m ideal opening switches (Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealOpeningSwitch).
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasi-static formulation.
</p>
</html>"));
end IdealOpeningSwitch;
