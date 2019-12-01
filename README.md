# 2019 Yonsei Univ(CSI2111-01) Verilog Project
## Teammate
> * [tojslee](https://github.com/tojslee)
> * [ChoSeokJu](https://github.com/ChoSeokJu)
> * [Fusoppark](https://github.com/Fusoppark)

## SAM CPU Implementation
> * Instructions

  |OP code|Instruction|Action|
  |:-------:|:-----------:|:------:|
  |00|Load from memory|Mem[Address] --> AC|
  |01|Store to memory|AC --> Mem[Address]|
  |10|Add from memroy|AC + Mem[Address] --> AC|
  |11|Branch if accumulator is negative|IF AC <0, Address --> PC|
>* more on 2019 final-project.pdf
