# *****Dimensionality Reduction using T-SNE algorithm****

include("convertDataFrameToMatrix.jl")
include("csvGenerator.jl")

# Path with the CSV to obtain the Normalize Data 
path = joinpath(
        @__DIR__, "..", 
        "data", 
        "normalize_data_frequency_matrix_giant.csv"
    )

# Define data in a Linear Algebra Matrix
X = convertDataFrameToMatrix(path)

# Applying Dimensionality Reduction with TSNE
@sk_import manifold : TSNE
tfn = TSNE(n_components=2) #,perplexity=20.0,early_exaggeration=50)
dimensionality_reduction_data = tfn.fit_transform(X);

#Export in CSV the dimensionality Reduction data
createDimensionalityReductionDataCSV(dimensionality_reduction_data)