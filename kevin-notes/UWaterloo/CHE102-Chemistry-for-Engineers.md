# Chem
### Gas Laws
- gas laws are equations relating Volume, moles, temperature and pressure of gases
  - `V = f(n,T,P)`
  - Ideal gas law states `PV = nRT`, R is a gas constant, which can be expressed in many combinations of units
- pressure is force per area, the collision of gas against a wall of a container
  - measured in Newtons per m^2 (Pascal)
- Boyle's Law is the relationship between pressure and volume for fixed amount of gas ( constant `nRT`)
- Law of Charles 
- absolute temperature (Kelvin) is used for gas relationships

### Dalton's Law
- different types of gases in a mixture act independently from each other
- this introduces partial pressures, each gas has it's own mol value and pressure value for constant V and T
  - partial pressures are additive, the pressure exerted on a container by the gas independently 
- partial pressure can be used for molar fractions (what percentage of the mixture does the given gas make up for?)

### Kinetic Theory of Gases
- a model for gas behaviour, provides theoretical justification for ideal gas law
  - states a gas is composed of lots of particles in constant, random motion
  - gas is mostly empty space
  - molecules collide with others or walls
  - no intermolecular forces, other than collisions
  - molecules gain or lose energy during elastic collisions, but net energy remains constant
- translational kinetic energy: `ek = (1/2)• m • u^2` (`u` is velocity)
- frequency of collision: `f ∝ u • (N / V)`
- momentum transfer to wall: `µ ∝ m • u`
- Gas pressure: `P ∝ µ • f ∝ (m•u)•u•(N/V) ∝ mu^2•(N/V)`
- then, assuming all molecules have the same speed, we can approximate: `P = (1/3)mu^2(N/V)`, where u is the rms speed

### Liquids and Solutions
- phase is a region of uniform properties
- at phase equilibrium there is no net conversion from one phase to another
- vapour pressure is the pressure at phase equilibrium, independent of the size of the system and correlative with temp/boiling point
- h2o forms partial dipoles and water forms tetrahedral shapes of 5 molecules, O is partial negative
- vapour pressure
- Antoine's equation for Pvap: `log Pvap = A - B/(C+T)`, where A, B, C are constants; properties of a substance
- heat is necessary to accomplish phase transition
  - the heat is measured at constant pressure called enthalpy
- Clausius-Clapeyron equation for Pvap is correlation between Pvap to tempurature
  - `ln(Pvap2/Pvap1) = delta Hvap/R • (1/T1 - 1/T2)`
- phase diagrams graph Pressure vs. Temperature, showing the state of a compound for a given temp and pressure 

### Henry's Law
Ideal solutions are ones where solvent and solute do not interact with each other

Henry's law applies to gas-liquid solutions
- relates partial pressure of gas (solute) to its molar fraction in the liquid (solvent):
- `Pi = ki•xi`, ki is Henry's law constant, and depends on solute,solvent,temp
- important for calculating solubility, `xi`

### Ideal Solutions and Raoult's Law
Relates partial pressure of a gas to its vapour pressure in liquid/liquid and liquid/solid solutions: `Pi = xi•Pvap,i`
- a solution of dissolved non-volatile solute (sugar) in water is an ideal solution, obeys Raoult's Law and Henry's Law
- 4 colligative properties:
  - vapour pressure lowering
  - boiling point elevation
  - freezing point depression
  - osmotic pressure

#### Vapour-pressure lowering
- Raoult's Law: P = Pliquid + Psolid = x1•Pvap,1 + x2•Pvap,2
- for non-volatile solids, Pvap,2 = 0
  - P = Pliquid = x1 • Pvap,1
- since x1 < 1 (theres dissolved solid) and P < Pvap (by dalton's law of partial pressures) then vapour pressure lowering is calculated by:
  - delta P1 = P - Pvap,1 = x1 • Pvap,1 - Pvap,1
  
#### Boiling Point Elevation
Normal boiling point of a pure liquid is the temp at which Pvap = 1atm
- according to Raoult's Law, vapour pressure of liquid/solid solution is less than that of the pure liquid
- temperature of the solution might be increased to make it boil
- `delta Tb = Kb•m`, m is the molality of the solution
- if a solution dissociates, the number of solute particles increases
- since colligative properties depend on number of dissolved particles, the equation adjusts 
- the required change is hte insertion of `i`, the van't Hoff factor
  - parameter `i` equals number of particles released into solution per formula unit of solute

#### Freezing Point Depression 
`delta Tf = -i•Kf•m`, Kf depends only on solvent type

### Chemical Equilibrium
Dissociation to ions (including oxidation and reduction)
- Equilibrium Constant K<sub>c</sub> = &Pi;[products]/&Pi;[reactants] where [] denotes conceptration in mol/L
- chemical equilibrium is when concentration of reactants and products remain constant
  - dynamic process, forward rate = backwards rate
- *for solving chemical equilibrium questions, try to find concentrations or partial pressures for the compounds in the equation, then get Kc and Kp*

- Ksp is the solubility product constant, for solid ionic solute and a liquid solvent
- Ksp = [C]<sup>c</sup> • [D]<sup>d</sup>
- the solubility of a solid in a solvent in the concentration of the dissolved salt in a saturated solution for a given temperature

### Common Ion Effect
If NaCl dissociates in AgCl solution, then theres extra [Cl-]; Q = [Ag+][Cl-] > Ksp. So the extra [Cl-] ions precipitate to restore [Ag+][Cl-] to equilibrium Ksp.

### Reaction Quotient

### Electrochemistry
Oxidation state is related to the number of electrons that an atom gains or loses when combining with outher atoms
- O.S. is the number of valance electrons needed to make a complete valence
- "LEO GR" for free electrons
  - break reaction into two half reactions
  - acidic medium: add H+ to hydrogen-deficient side
  - basic medium: add H2O to the hydrogen-deficient side and OH- to the other
  
### Galvanic Cell
Oxidation occurs at the anode, electrons flow from the anode, it shows negative charge
- reduction occurs at the cathode, electrons flow to the cathode, it shows positive charge
- salt bridge allows ions to diffuse from one side to the other

- cell dies if it reaches equilibrium, or if you run out of solid reactant
  - they are not in the equilibrium equation
  
**Faraday's Law** says the mass of a given substance produced or consumed at an electrode is proportional to the quantity of electric charge passed through the cell

### Cell Potential

### Chemical Kinetics
Describe how fast a reaction takes place
- think change in concentration with respect to time
- for 2 SO<sub>2</sub> + O<sub>2</sub> -> 2 SO<sub>3</sub>, reaction rate r = - 1/2 d[SO<sub>2</sub>]/dt = -d[O<sub>2</sub>]/dt = 1/2 d[SO<sub>3</sub>]/dt
- r = -1/a d[A]/dt = k[A]<sup>n</sup>[B]<sup>m</sup>, r as a function of reactants aA + bB -> ------ 
  - n and m are given, determined through experiment. n and m are the order of the reaction with respect to A and B

### Integrated Rate Law
Concentration is represented by linear functions f([A]) = -kt + [A0], with the following:
- 0 order, [A] vs time is linear, with slope -k
- 1st order, ln[A] vs time is linear, with slope -k
- 2nd order, 1/[A] vs time is linear, with slope -k

### Activation Energy
k = A * e^(-E<sub>a</sub>/RT), where A and Ea are constants that depend on the reaction type
  
# Useful Examples
- 10-2 for relating phase pressures to temperatures
- 13-1 for raoult's law
