# Identify and execute different type of unsupervised learning models

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

CLUSTER_NUMBER = 5

# ------- K-MEANS CLUSTERING ---------
function kmeans_clustering(path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Processing kmeans clustering
    C = ParallelKMeans.kmeans(X', CLUSTER_NUMBER)
    # Add column with the kmeans clustering results
    insertcols!(
        dataFrameUsersWithEvents,
        2,
        :kmeans=>C.assignments, 
        makeunique=true
        )
    # Create a CSV with the kmeans clustering results
    createClusteringResultsCSV(dataFrameUsersWithEvents)
end

# ------- K-MEDOIDS CLUSTERING ---------
function kmedoids_clustering(path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Define distance for the kmedois algorithm 
    D = pairwise(Euclidean(), X', X', dims=2)
    # Processing kmedoids clustering
    K = kmedoids(D, CLUSTER_NUMBER)
    # Add column with the kmedoids clustering results
    insertcols!(
        dataFrameUsersWithEvents,
        2,
        :kmedoids=>K.assignments, 
        makeunique=true
        )
    # Create a CSV with the kmedoids clustering results
    createClusteringResultsCSV(dataFrameUsersWithEvents)
end

# ------- HIERARCHICAL CLUSTERING ---------
function hierarchical_clustering(path::String)
    # Define data in a Linear Algebra Matrix
    X = convertDataFrameToMatrix(path)
    # Define distance for the hierarchical algorithm 
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
    # Create a CSV with the hierarchical  clustering results
    createClusteringResultsCSV(dataFrameUsersWithEvents)
end

# ------- FUZZY C-MEANS CLUSTERING ---------
function fuzzy_c_means_clustering(path::String)
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
    # Create a CSV with the fuzzy_c_means clustering results
    createClusteringResultsCSV(dataFrameUsersWithEvents)
end

# Execute diferents unsupervised learning methods 

# with high  dimension data
kmeans_clustering(pathHighDimensions)
kmedoids_clustering(pathHighDimensions)
hierarchical_clustering(pathHighDimensions)
fuzzy_c_means_clustering(pathHighDimensions)

# with low dimension data
kmeans_clustering(pathLowDimensions)
kmedoids_clustering(pathLowDimensions)
hierarchical_clustering(pathLowDimensions)
fuzzy_c_means_clustering(pathLowDimensions)