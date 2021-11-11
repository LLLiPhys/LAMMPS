#!/bin/bash

echo "make an orthogonal cell ? (yes/no)"
read var1

echo "make a supercell ? (yes/no)"
read var2

if [ $var2 == "yes" ]; then
    echo "specify the supercell size: "
    read var3 var4 var5
fi

if [ $var1 == "yes" ]; then
    if [ $var2 == "yes" ]; then
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z -orthogonal-cell -duplicate $var3 $var4 $var5 POSCAR
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z -orthogonal-cell -duplicate $var3 $var4 $var5 data.lmp
    else
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z -orthogonal-cell POSCAR
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z -orthogonal-cell data.lmp
    fi
else
    if [ $var2 == "yes" ]; then
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z -duplicate $var3 $var4 $var5 POSCAR
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z -duplicate $var3 $var4 $var5 data.lmp

    else
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z POSCAR
        atomsk --create graphite 2.46 20 C -cut above 0.2 Z data.lmp
    fi
fi
