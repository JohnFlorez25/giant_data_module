include("csvGenerator.jl")
include("graphicsGenerator.jl")

# Path with the CSV to obtain the Normalize Data 
pathHighDimensions = joinpath(@__DIR__, "..", "data", "normalize_data_frequency_matrix_giant.csv")

# Path with the CSV to obtain the Low Dimensionality Data
pathLowDimensions = joinpath(@__DIR__, "..", "data", "dimensionality_reduction_data.csv")


CLUSTER_NUMBER = 4

function kmeans_clustering(typeOfData::Int64,path::String)
    # Define obtain Data in DataFame
    data= DataFrame(CSV.File(path))
    # Define data in a Linear Algebra Matrix
    X = Matrix(convert(Array{Float64}, data ))
    # Processing kmeans clustering
    C = kmeans(Matrix(X)', 
        CLUSTER_NUMBER
        )
    # Add column with the kmeans clustering results
    insertcols!(
        data,
        1,
        :kmeans_4=>C.assignments, 
        makeunique=true
        )
    # Create a CSV with the kmeans clustering results
    createKmeansClusteringResultsCSV(typeOfData, data)
end

kmeans_clustering(1,pathHighDimensions)
kmeans_clustering(2,pathLowDimensions)