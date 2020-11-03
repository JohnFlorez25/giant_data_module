# ***** Principal script to charge the package and execute the code ****
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
using ScikitLearn
using Dates
# using ParallelKMeans
using Clustering
# using UMAP
# using Makie
# using XLSX
# using VegaDataset
# using RDatasets
# using MLBase
#gr()

## source_files
include("dataFeatureEngineering.jl")
include("dataPreprocessing.jl")
include("dataNormalization.jl")
include("featureEngineering.jl")
include("dimensionalityReduction.jl")
include("optimalNumberClusters.jl")
include("unsupervisedLearning.jl")

