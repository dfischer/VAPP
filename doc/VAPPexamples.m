%VAPP comes with a number of illustrative examples, detailed below. Each
%example starts from a Verilog-A description of a model, runs VAPP to translate
%it to ModSpec, and then tests the model by making a small circuit with it and
%running it in a MAPP analysis. The examples also illustrate the types of
%changes typically needed to existing Verilog-A models to make them NEEDS-
%(therefore VAPP-) compatible.
%
%The examples are organized under the 'examples' directory under the VAPP root
%directory, but you can examine and run them directly from the MATLAB or Octave
%command line, as shown below, without worrying about where they are located.
%You should, of course, have a working VAPP and MAPP setup -- please refer to
%the README file in the root VAPP directory and the README file in the root
%MAPP repository (https://github.com/jaijeet/MAPP) for details.
%
%The Verilog-A files for the models used by the examples are included with
%VAPP. Moreover, the VAPP-translated ModSpec models have been pre-generated and
%are included for convenience, since VAPP takes a long time (10s of minutes) to
%translate some of the larger models.
%
%Many of these examples are related to MAPP's examples ('help MAPPexamples'
%for more information) and are typically composed of multiple m-files. The
%main script file for each example has the name format
%
%    run_modelName_analysisName.m
%
%where modelName is the name of the device model and analysisName is the name
%of the MAPP analysis/simulation used in the demonstration.  Each 'run' script
%contains a call to va2modspec that translates the Verilog-A model in the
%example to ModSpec. By default, these calls to va2modspec are commented out.
%If you want to translate the models yourself, uncomment the call to va2modspec
%in the 'run_*' file.
%
%The examples are described further below. Simply cutting and pasting the run
%scripts in MATLAB or Octave (with VAPP and MAPP loaded) will run the examples.
%
%
%
%List of Example Scripts to run (for the impatient)
%==================================================
%
%run_bsim3_ring_oscillator
%run_bsim4_iv_curves
%run_bsim6_iv_curves
%run_mvs1_inverter_transient
%run_psp_csamp_transient
%run_purdue_ncfet_homotopy
%run_r3_self-heating_transient
%run_vbic_diffpair_ac
%
%
%
%BSIM3
%=====
%
%Version: BSIM3 v3.2.4
%Link to the original model code: http://bsim.berkeley.edu/models/bsim4/bsim3/
%Circuit example in MAPP: a ring oscillator
%Folder: examples/bsim3_ring_oscillator
%Files: bsim3.m, bsim3.va, bsim3_ringosc_ckt.m, run_bsim3_ringosc_transient.m
%
%This example demonstrates how to construct a 3-stage ring oscillator circuit
%in MAPP and perform a transient analysis on it.
%The file bsim3_ringosc_ckt.m sets the parameters for the transistors in the
%ring oscillator and afterwards constructs the entire circuit using MAPP's
%netlist format. This circuit is then converted to a DAE using MAPP's DAEAPI.
%The main script, run_bsim3_ringosc_transient, calls bsim3_ringosc_ckt to
%create the circuit and then performs a transient simulation on it.
%
%To see the plot of the node voltages, simply run the main script,
%'run_bsim3_ringosc_transient'.
%
%Although the translated ModSpec file is provided inside the example
%directory, you can uncomment the call to va2modspec (line 7) in
%run_bsim3_ringosc_transient and have VAPP translate the Verilog-A model before
%running the simulation.
%
%BSIM4 and BSIM6
%===============
%
%  BSIM4
%  =====
%  Version: BSIM4.3.0
%  Link to the original model code: http://bsim.berkeley.edu/models/bsim4/
%  Circuit example in MAPP: I-V curves
%  Folder: examples/bsim4_iv_curves
%  Files: bsim4_vappmod.va, bsim4.m, run_bsim4_iv_curves.m
%
%  This example computes the drain current of a transistor using the BSIM4
%  model for different values of gate and drain voltages. The source and the
%  bulk potentials are held at zero.
%
%  To see the plots, run the file 'run_bsim4_iv_curves.m' and press Enter when
%  prompted by the script.
%
%  Original model version:
%       Berkeley BSIM4.3.0 Verilog-A model (UPDATED March 8,19 2004)
%
%  Modifications to the original model for VAPP:
%   1. Changed module name from 'mosfet' to 'bsim4'
%      (only for clarity, not a necessary change)
%      -------------------------------------------
%      Line number: 41
%      -------------------------------------------
%
%   2. Put ifndef __VAPP__ around the @(initial_step) statement.
%      -------------------------------------------
%      Line number: 963
%      -------------------------------------------
%
%   3. Added real keyword to parameter definitions.
%      -------------------------------------------
%      Line numbers: 56 - 363
%      -------------------------------------------
%
%   4. Set the default value for RGATEMOD parameter to 0.
%      -------------------------------------------
%      Line number: 82
%      -------------------------------------------
%
%   NOTE: Simulator directives like @(initial_step), @(cross), @(final_step)
%         are prohibited by NEEDS compatibility rules. Such statements, which
%         make sense only for one analysis (eg, transient analysis) but are
%         meaningless for others (eg, AC analysis), break the principle that
%         a model should work in every analysis (and not be aware of what
%         analysis it will be used in). Using them typically leads to different
%         analyses producing inconsistent results.
%         
%  
%  BSIM6
%  =====
%
%  Version: BSIM6 6.1.1
%  Link to the original model code: http://bsim.berkeley.edu/models/bsimbulk/
%  Circuit example in MAPP: I-V curves
%  Folder: examples/bsim6_iv_curves
%  Files: bsim6.1.1_vappmod.va, bsim6.m, run_bsim6_iv_curves.m
%
%  This example performs the same function as the BSIM4 I-V curves example.
%  I.e., it creates an instance of the BSIM6 model and then performs a DC sweep
%  for the gate and drain voltages and produces 3D plots.
%
%  To see the plots run the file 'run_bsim6_iv_curves.m' and press Enter when
%  prompted by the script.
%
%  NOTE: BSIM6 is especially slow in MAPP until (after some time) Matlab's JIT
%        engine compiles the code.
%  TODO: This example needs better parameter values to produce nicer curves.
%
%  Modifications to the original model for VAPP:
%  1. Replaced access functions (I(),V()) that were referenced to the global
%     ground with a reference to the bulk node.
%     Tip: search for V([^,]*) in vim, i.e., use the following command
%        "/V([^,]*)" without the quotes.
%
%  2. Commented out lines with ddx calls.
%     -------------------------------------------
%     Line numbers: 4217 - 4365 and 4393 - 4395
%     -------------------------------------------
%
%  3. Initialized the following variables to zero: 
%       local_sca = 0;
%       local_scb = 0;
%       local_scc = 0;
%     --------------------------------------------------
%     Line numbers: 2013 - 2015 (in bsim6.1.1_vappmod.va)
%     --------------------------------------------------
%     
%  NOTE: Commenting out ddx() function calls does not affect the actual
%        functioning of the model in simulation, since they are used only for
%        printing out the values of small-signal parameters. VAPP does not
%        support ddx() yet.
%
%
%        
%  
%MVS1
%====
%
%Version: 1 (July 17 2015)
%Link to the original model code: https://nanohub.org/publications/15/4
%Circuit example in MAPP: a CMOS inverter
%Folder: examples/mvs_inverter_transient
%Files: mvs_si_1_1_0.m, mvs_si_1_1_0.va, MVSinverter_ckt.m,
%       run_mvs_inverter_transient.m
%
%This example constructs a CMOS inverter circuit using the MVS transistor model
%and then runs a transient simulation on it.
%
%Run the script 'run_mvs_inverter_transient'.
%
%  Modifications to the original model for VAPP:
%  1. In MVS1, branch voltages are computed using the potential difference 
%     between the two nodes of the branch. I.e., the voltage across nodes 'n1'
%     and 'n2' is computed by
%
%       V(n1) - V(n2).
%
%     NEEDS compatibility requires the conversion of probes and sources of 
%     this fashion to
%
%       V(n1,n2)
% 
%     Tip: in Vim run the following command.
%
%       :%s/V(\(.\{-}\)) - V(\(.\{-}\))/V(\1,\2)/gc
%
%
%
%
%PSP
%===
%
%Version: 103.3.0, December 2013
%Link to the original model code: http://www.nxp.com/products/software-and-tools/models-and-test-data/compact-models-simkit/mos-models/model-psp:MODELPSP
%Circuit example in MAPP:  A common source amplifier
%Folder: examples/psp_csamp_transient
%Subfolder: psp103 (contains the Verilog-A files)
%Files: PSP103VA.m psp_csamp_ckt.m run_psp_csamp_transient.m
%
%This is a simple common source amplifier circuit (one transistor and one
%resistor). The input to the circuit is a box car pulse. The output is the
%inverted version of the input signal.
%
%Run the script 'run_psp_csamp_transient'.
%
%  Modifications to the original model for VAPP:
%  
%  1. Common103_macrodefs.include:
%       
%       `define CLIP_LOW(val,min)      ((val)>(min)?(val):(min))
%       `define CLIP_HIGH(val,max)     ((val)<(max)?(val):(max))
%       `define CLIP_BOTH(val,min,max) ((val)>(min)?((val)<(max)?(val):(max)):(min))
%  
%     is changed to
%  
%       `define CLIP_LOW(val,min_val)      ((val)>(min_val)?(val):(min_val))
%       `define CLIP_HIGH(val,max_val)     ((val)<(max_val)?(val):(max_val))
%       `define CLIP_BOTH(val,min_val,max_val) ((val)>(min_val)?((val)<(max_val)?(val):(max_val)):(min_val))
%
%     -------------------------------------------
%     Line numbers: 31-33
%     -------------------------------------------
%
%     NOTE: 'min' and 'max' are reserved keywords in MATLAB.
%
%  2. Also, min_val and max_vals should be added to the list of variable
%     declarations to PSP103_module.include.
%
%  3. PSP103_module.include:
%     Referenced NOI branches and access functions to noise node (NOI2) to the
%     bulk node (B).
%
%       branch (NOI) NOII;
%       branch (NOI) NOIR;
%       branch (NOI) NOIC;
%
%     is changed to
%
%       branch (NOI, B) NOII;
%       branch (NOI, B) NOIR;
%       branch (NOI, B) NOIC;
%
%     -------------------------------------------
%     Line numbers: 45-47
%     -------------------------------------------
%
%  4. psp103.va:
%     Commented out `ifdef OPderiv (VAPP does not support ddx yet).
%
%     -------------------------------------------
%     Line number: 36
%     -------------------------------------------
%
%  NOTE: Commenting out ddx() function calls does not affect the actual
%        functioning of the model in simulation, since they are used only for
%        printing out the values of small-signal parameters (eg, capacitances).
%        VAPP does not support ddx() yet.
% 
% 
% 
%
%
%Purdue Negative Capacitance FET
%===============================
%
%Version: 1.1.0 (04/05/2016)
%Link to the original model code: https://nanohub.org/publications/95/2
%Circuit example in MAPP: Homotopy analysis on a diode connected NCFET
%Folder: examples/purdue_ncfet_homotopy
%Files: mvs_5t_mod.m mvs_5t_mod_vappmod.va neg_cap_3t.m neg_cap_3t_vappmod.va
%       run_neg_cap_3t_dcsweep.m run_purdue_ncfet_diode_connect_homotopy.m
%       run_purdue_ncfet_homotopy.m 
%
%The Purdue negative capacitance model (https://nanohub.org/publications/95/2)
%is a modular compact model which consists of a negative capacitance model and
%a modified MVS FET model. To construct a negative capacitance FET model, the
%negative capacitance model is attached to the gate terminal of the FET model
%and the auxiliary terminals (qg_as_v) in both models are connected together.
%
%In the first example, we connect the drain and the gate terminals of the
%negative capacitance FET together (ie, make a diode-connected FET) and run
%MAPP's DC sweep on it. A second example plots characteristic curves using
%MAPP's homotopy analysis, which essentially performs a DC sweep but is capable
%of capturing "folds" and hysteresis (present, in this case, due to negative
%capacitance).  
%
%To run a DC sweep of the diode-connected FET, execute the script
%       'run_neg_cap_3t_dcsweep'.
%To see its characteristic curves, execute the script
%       'run_purdue_ncfet_homotopy'.
%
%NOTE: The term 'negative capacitance' is used as short-hand for 'negative
%      differential capacitance', i.e., the capacitor is a nonlinear device
%      with a differential capacitance value (slope of the q-v curve) that is
%      negative in some bias regions. 
%
%  Modifications the original model for VAPP:
%  
%  1. For the changes in the transistor model (MVS) please see the MVS example.
%
%  2. neg_cap_3t.va:
%     The module definition on line 54 has to be changed as
%
%       module neg_cap_3t(ncp, qg_as_v, ncn);
%
%     The 'qg_as_v' terminal is used as an input to transfer the gate charge 
%     information from the transistor model to the capacitor. To comply with
%     NEEDS requirement of using only branches in access functions, these
%     functions in the model equations have to be changed as follows.
%
%       V(ncp,ncn)   <+ 2*alpha*tFE*(V(qg_as_v, ncn)*1e-6)+4*beta*tFE*pow((V(qg_as_v, ncn)*1e-6),3.0)+6*gamma*tFE*pow((V(qg_as_v, ncn)*1e-6),5.0); 
%       V(ncp,ncn)   <+ rho*tFE*ddt(V(qg_as_v, ncn)*1e-6);
%
%     -------------------------------------------
%     Line numbers: 69 - 70
%     -------------------------------------------
%
%
%
%
%R3 Polysilicon Resistor Model
%=============================
%
%Version: 2.0.0, October 30, 2014
%Link to the original model code: https://nanohub.org/publications/26/1
%Circuit example in MAPP: Demonstration of the resistance increase via self 
%                         heating
%Folder: examples/r3_self-heating_transient
%Files: generalMacrosAndDefines.va junctionMacros.va r3.m r3.va r3_vappmod.va
%       r3Macros.va run_r3_transient.m
%
%This simple example runs a transient simulation with R3's self-heating feature
%enabled. The parameters of the model are chosen such that the resistor heats
%up very quickly which increases the resistance value. This behavior can be
%nicely observed in the output voltage graph.
%
%Run the script 'run_r3_transient'.
%
%  Modifications to the original model for VAPP:
%
%   1. Commented out OPinfo (ddx) calculations on lines 752-762. 
%
%   2. Referenced the dt node to n2 on lines 65-66.
%
%
%
%
%VBIC
%====
%
%Version: 1.2
%Link to the original model code: http://www.designers-guide.org/VBIC/
%Circuit example in MAPP: a BJT differential pair
%Folder: examples/vbic_diffpair_ac
%Files: run_vbic_diffpair_ac.m vbic.m vbic1.2_vappmod.va vbic_diffpair_ckt.m
%
%This example uses the VBIC bipolar transistor model to construct a
%differential pair and performs an AC analysis on this circuit.
%
%Run the script 'run_vbic_diffpair_ac'.
%
%  Modifications to the original model for VAPP:
%   1. Vbic uses macros in the following form
%        `define psibi(P,Ea,Vtv,rT) \
%           psiio = 2.0*(Vtv/rT)*log(exp(0.5*P*rT/Vtv)-exp(-0.5*P*rT/Vtv)); \
%           psiin = psiio*rT-3.0*Vtv*log(rT)-Ea*(rT-1.0); \
%           psibi = psiin+2.0*Vtv*log(0.5*(1.0+sqrt(1.0+4.0*exp(-psiin/Vtv))));
%
%      and calls them like this
%       
%       PEatT   =  `psibi(PE,EAIE,Vtv,rT);
%
%      Macro definitions of this form (where the return value is the name of
%      the macro) are not standardized in the Verilog-A language and are not
%      supported by VAPP. They have been changed to the following form:
%
%     `define psibi(out,P,Ea,Vtv,rT) \
%          psiio = 2.0*(Vtv/rT)*log(exp(0.5*P*rT/Vtv)-exp(-0.5*P*rT/Vtv)); \
%          psiin = psiio*rT-3.0*Vtv*log(rT)-Ea*(rT-1.0); \
%          out = psiin+2.0*Vtv*log(0.5*(1.0+sqrt(1.0+4.0*exp(-psiin/Vtv))));
%
%      by adding an "output argument" out.
%
%      These changes have been made for multiple macros at the start of the
%      file vbic1.2.va.
% 
%
%
%
%See also
%--------
%VAPPquickstart, aboutVAPP, va2modspec

help VAPPexamples
