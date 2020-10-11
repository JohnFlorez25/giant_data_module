include("graphicsGenerator.jl")

# Path with the CSV to obtain the Normalize Data 
path = joinpath(@__DIR__, "..", "data", "normalize_data_frequency_matrix_giant.csv")

# Define Normalize Data in a DataFrame
normalizeData = DataFrame(CSV.File(path))

# Define Normalize Data in a Linear Algebra Matrix
X = Matrix(convert(Array{Float64}, normalizeData ))

# Define de number of clusters
x = 2:25

# Single Thread Implementation of Lloyd's Algorithm
y = [ParallelKMeans.kmeans(Matrix(X)', i, n_threads=1; tol=1e-6, max_iters=300, verbose=false).totalcost for i = 2:25]

createClusterOptimalNumberPlot(x,y)