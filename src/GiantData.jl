# Packages we will use 
using DataFrames
using JSON
using CSV
using Plots
using Lathe
using Statistics
using StatsPlots
using StatsBase
using MultivariateStats
using LinearAlgebra
using Distances
using ParallelKMeans
using ScikitLearn
using Clustering
# using UMAP
# using Makie
# using XLSX
# using VegaDataset
# using RDatasets
# using MLBase
#gr()

## source_files

include("dataPreprocessing.jl")
include("dataNormalization.jl")
include("dimensionalityReduction.jl")
include("optimalNumberClusters.jl")
include("unsupervisedLearning.jl")

