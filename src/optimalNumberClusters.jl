include("graphicsGenerator.jl")

# Path with the CSV to obtain the Normalize Data 
pathHighDimensions = joinpath(@__DIR__, "..", "data", "normalize_data_frequency_matrix_giant.csv")

# Path with the CSV to obtain the Low Dimensionality Data
pathLowDimensions = joinpath(@__DIR__, "..", "data", "dimensionality_reduction_data.csv")

function elbowMethodCluster(typeOfData::Int64,path::String)
    # Define obtain Data in DataFame
    data= DataFrame(CSV.File(path))
    # Define data in a Linear Algebra Matrix
    X = Matrix(convert(Array{Float64}, data ))
    # Define de number of clusters
    x = 2:25
    # Single Thread Implementation of Lloyd's Algorithm
    y = [ParallelKMeans.kmeans(Matrix(X)', i, n_threads=1; tol=1e-6, max_iters=300, verbose=false).totalcost for i = 2:25]
    # Calling the funciton to create elbow method
    createClusterOptimalNumberPlot(typeOfData,x,y)
end

elbowMethodCluster(1,pathHighDimensions)
elbowMethodCluster(2,pathLowDimensions)