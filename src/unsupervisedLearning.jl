include("convertDataFrameToMatrix.jl")
include("csvGenerator.jl")
include("graphicsGenerator.jl")

# Path with the CSV to obtain the Users with the number of executed events
pathEventUsers = joinpath(@__DIR__, "..", "data", "frequency_events_users_giant.csv")

# Convert to DataFrame Events Users Data
dataFrameUsersWithEvents= DataFrame(CSV.File(pathEventUsers))

# Path with the CSV to obtain the Normalize Data 
pathHighDimensions = joinpath(@__DIR__, "..", "data", "normalize_data_frequency_matrix_giant.csv")

# Path with the CSV to obtain the Low Dimensionality Data
pathLowDimensions = joinpath(@__DIR__, "..", "data", "dimensionality_reduction_data.csv")

CLUSTER_NUMBER = 4

# ------- K-MEANS CLUSTERING ---------
function kmeans_clustering(typeOfData::Int64,path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Processing kmeans clustering
    C = kmeans(X', CLUSTER_NUMBER)
    # Add column with the kmeans clustering results
    insertcols!(
        dataFrameUsersWithEvents,
        2,
        :kmeans=>C.assignments, 
        makeunique=true
        )
    # Create a CSV with the kmeans clustering results
    createClusteringResultsCSV(typeOfData, dataFrameUsersWithEvents)
end

# ------- K-MEDOIDS CLUSTERING ---------
function kmedoids_clustering(typeOfData::Int64,path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Define distance for the kmedois algorithm 
    D = pairwise(Euclidean(), X', X', dims=2)
    # Processing kmeans clustering
    K = kmedoids(D, CLUSTER_NUMBER)
    # Add column with the kmedoids clustering results
    insertcols!(
        dataFrameUsersWithEvents,
        2,
        :kmedoids=>K.assignments, 
        makeunique=true
        )
    # Create a CSV with the kmeans clustering results
    createClusteringResultsCSV(typeOfData, dataFrameUsersWithEvents)
end

# ------- HIERARCHICAL CLUSTERING ---------
function hierarchical_clustering(typeOfData::Int64,path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Define distance for the kmedois algorithm 
    D = pairwise(Euclidean(), X', X', dims=2)
    # Processing hierarchical clustering
    K = hclust(D, linkage=:ward)
    L = cutree(K; k=CLUSTER_NUMBER)
    # Add column with the hierarchical clustering results
    insertcols!(
        dataFrameUsersWithEvents,
        2,
        :hclust=>L, 
        makeunique=true
        )
    # Create a CSV with the kmeans clustering results
    createClusteringResultsCSV(typeOfData, dataFrameUsersWithEvents)
end

# ------- FUZZY C-MEANS CLUSTERING ---------
function fuzzy_c_means_clustering(typeOfData::Int64,path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Processing fuzzy_c_means clustering
    R = fuzzy_cmeans(
        X', 
        CLUSTER_NUMBER, 
        2, 
        maxiter=200, 
        display=:iter)
    # Select the maximum probable cluster
    FC = mapslices(argmax, R.weights, dims=2)
    t = vcat(FC...)
    # Add column with the fuzzy_c_means clustering results
    insertcols!(
        dataFrameUsersWithEvents,
        2,
        :fuzzy=>t, 
        makeunique=true
        )
    # Create a CSV with the kmeans clustering results
    createClusteringResultsCSV(typeOfData, dataFrameUsersWithEvents)
end

# Execute diferents unsupervised learning methods 
# with high dimension data
kmeans_clustering(1,pathHighDimensions)
kmedoids_clustering(1,pathHighDimensions)
hierarchical_clustering(1,pathHighDimensions)
fuzzy_c_means_clustering(1,pathHighDimensions)

# kmeans_clustering(2,pathLowDimensions)
# kmedoids_clustering(2,pathLowDimensions)

