# EpigeneticDrift
DNA methylation; Epigenetic Drift; Aging

![Build](https://github.com/Fun-Gene/EpigeneticDrift)

# A robust epigenetic drift score associated with aging dimensions

### Xiu Fan Qili Qian

### Fan Liu lab

# Introduction

Epigenetic drift, typified by stochastic variations in DNA methylation at distinct CpG loci, is integral to aging and its concomitant phenotypes. Conventional methods for identifying drifting CpGs have demonstrated limitations in statistical power and in their ability to correlate with aging indices. In response, we introduce a novel algorithm Two-Step Absolute Residual Linear Model (TARLM) exhibiting superior statistical power for detecting drift-CpGs compared to existing methodologies. We executed an Epigenome-Wide Drift Study (EWDS) in a discovery cohort, followed by replication studies in independent cross-ethnicity cohorts.Our study has produced a series of ground-breaking findings, collectively advancing our comprehension of epigenetic drift and its functional implications in aging and associated pathophysiological conditions.


This repo contains code needed to generate figures for the paper 

    https://www.biorxiv.org/

The code is under development

## The analysis is performed in 3 steps:

1. Epigenome-Wide Drift Study (EWDS)using Two-Step Absolute Residual Linear Model (TARLM)
2. Genome-wide Epigenetic Drift Score (EDS)
3. R markdown notebooks used for merging of the samples, analysis and figure generation

## Step 1. 

Each CpG site is processed separately with TARLM:

    TARLM(CpG, Age, cov = NULL)


## Step 2.

Each individual is predicted separately with EDS:

    get_EDS(CpG)


## Step 3.

cd into folder where you want to do the analyis

mkdir EpigeneticDrift
cd EpigeneticDrift
Clone the git repo

git clone https://github.com/Fun-Gene/EpigeneticDrift
Create conda environment with all necessary tools installed by:

conda env create -f EpigeneticDrift/envs/evmake.yaml
Install extra R libraries that are not present in conda or have trouble working:

TODO 


## More

More info about Epigenetic drift can be found on our [website](https:// ).  


Then, just go to File 

Enjoy!



