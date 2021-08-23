#!/bin/bash

nx=10 # number of cell repetions along x direction
ny=10 # number of cell repetions along y direction
nz=10 # number of cell repetions along z direction
percent=50 # percentage for which we create atomic vacancy/substitution/interstition
natoms=$[2*$nx*$ny*$nz] # total number of atoms in the supercell 
addatoms=$(echo "$natoms * $percent / 100" | bc -l) # convert percentage to number when adding atoms
addatoms=${addatoms%.*} # convert floating numbers to integers

echo "natoms = $natoms"
echo "addatoms = $addatoms"

echo "Creating Vacancy..."

atomsk --create diamond 5.39 Si \
	-duplicate $nx $ny $nz \
	-select random $percent% Si \
	-remove-atoms select Si-Point-Vacany-$percent-Percent.lmp \

echo "Creating Substitution..."

atomsk --create diamond 5.39 Si \
	-duplicate $nx $ny $nz \
	-select random $percent% Si \
	-substitute Si Ge Si-Ge-Substitution-$percent-Percent.lmp \


echo "Creating Intersition..."

atomsk --create diamond 5.39 Si \
	-duplicate $nx $ny $nz \
	-add-atom P random $addatoms Si-P-Interstition-$percent-Percent.lmp \


echo "Done"
