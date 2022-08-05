# Notes

Notes and hypotheses about InChI's structure based on published documentation.
  
- version
- disconnected
  - / main
    - formula
    - /c connections
    - /h H_atoms (static H and mobile H groups)
  - charge
    - /q charge
    - /p protons (not fixed)
  - stereo
    - /b stereo:dbond
    - /t stereo:sp3
    - /m stereo:sp3:inverted
    - /s stereo:type (1=abs, 2=rel, 3=rac)
  - /i isotopic
    - /h isotopic:exchangeable_H
    - /b isotopic:stereo:dbond
    - /t isotopic:stereo:sp3
    - /m isotopic:stereo:sp3:inverted
    - /s isototopic:stereo:type (1=abs, 2=rel, 3=rac)
  - /f fixed
    - /h fixed:H:H_fixed
    - /q fixed:H:charge
    - /t fixed_H:stereo:dbond
    - /m fixed:H:stereo:sp3:inverted
    - /s fixed_H:stereo:type (1=abs, 2=rel, 3=rac)
    - /i isotopic
      - /b fixed_H:isotopic:stereo:dbond
      - /t fixed_H:isotopic:stereo:sp3
      - /m fixed_H:isotopic:stereo:sp3:inverted
      - /s fixed_h:isotopic:stereo:type (1=abs, 2=rel, r=rac)
    - /o transposition
- /r reconnected
  - / main
    - /c connections
    - /h H_atoms
  - charge
    - /q charge
    - /p protons
  - stereo
    - /b stereo:dbond
    - /t stereo:sp3
    - /m stereo:sp3:inverted
    - /s stereo:type (1=abs, 2=rel, 3=rac)
  - /i isotopic
    - /h isotopic:exchangeable_H
    - /b isotopic:stereo:dbond
    - /t isotopic:stereo:sp3
    - /m isotopic:stereo:sp3:inverted
    - /s isototopic:stereo:type (1=abs, 2=rel, 3=rac)
  - /f fixed
    - /h fixed:H:H_fixed
    - /q fixed:H:charge
    - /t fixed_H:stereo:dbond
    - /m fixed:H:stereo:sp3:inverted
    - /s fixed_H:stereo:type (1=abs, 2=rel, 3=rac)
    - /i isotopic
      - /b fixed_H:isotopic:stereo:dbond
      - /t fixed_H:isotopic:stereo:sp3
      - /m fixed_H:isotopic:stereo:sp3:inverted
      - /s fixed_h:isotopic:stereo:type (1=abs, 2=rel, r=rac)
    - /o transposition

Algorithm:

Starts on Page 78.

1. Split L/R into two strings, V, S. L is version, S has all the layers.
2. Find `/r` in S. If found, P[1] = before, P[2] = after. Otherwise copy S to P[1]. P[1] is the layers or the layers of a disconnected structure. P[2] if not empty is the layers of a reconnected structure.
3. For each P in non-empty P[i], search for `/f`. If found, copy left to Q[i][1] (main layer) and right to Q[i][2] (fixed-H layer).
4. For each Q in non-empty Q[i][j], search for `/i`. If found, left is R[i][j][1] (non-isotopic) and right is R[i][j][2] (isotopic).

This procedure yields R[i][j][k] (i, j, k = 1 or 2), where:

- i = 1: the identifier, or the identifier of a disconnected structure
- i = 2: the identifier of the reconnected structure
- j = 1: the main layer
- j = 2: the fixed-H layer
- k = 1: the non-isotopic part of the layer
- k = 2: the isotopic part of the layer

From "Hierarchical structure of the Identifier"

- Main Layer
  - /{formula}
    - C5H5N5O
  - /c{connections}
    - 6-5-9-3-2(4(11)10-5)7-1-8-3
  - /h{H_atoms}
   - /h1H,(H4,6,7,8,9,10,11)
   - /h5H,1-4H3
   - /h(H4,2,3,4)
- Charge Layer
  - /q{charge}
    - component charge
  - /p{protons}
    - H+ removed from an atom
- Stereo Layer
  - /b{stereo:dbond}
  - /t{stereo:sp3}
  - /m{stereo:sp3:inverted}
  - /s{stereo:type (1=abs, 2=rel, 3=rac)}
- Isotopic Layer
  - /i{isotopic:atoms}*
  - /h{isotopic:exchangeable_H}
  - /b{isotopic:stereo:dbond}
  - /t{isotopic:stereo:sp3}
  - /m{isotopic:stereo:sp3:inverted}
  - /s{isotopic:stereo:type (1=abs, 2=rel, 3=rac)}
- Fixed H Layer (specific tautomer, optional)
  - /f {fixed_H:formula}*
  - /h {fixed_h:H_fixed}
    - /h8,10H,6H2
  - /q {fixed_H:charge}
  - /b {fixed_H:stereo:dbond}
  - /t {fixed_H:stereo:sp3}
  - /m {fixed_H:stereo:sp3:inverted}
  - /s {fixed_H:stereo:type (1=abs, 2=rel, 3=rac)}
- Fixed/Isotopic Combination (FI)
  - /i{fixed_H:isotopic:atoms}*
  - /b{fixed_H:isotopic:stereo:dbond}
  - /t{fixed_H:isotopic:stereo:sp3}
  - /m{fixed_H:isotopic:stereo:sp3:inverted}
  - /s{fixed_H:isotopic:stereo:type (1=abs, 2=rel, 3=rac)}
  - /o{transposition}
