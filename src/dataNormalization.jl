# Path with CSV Frequency Matrix Without users for the data normalization process
path = joinpath(@__DIR__, "..", "data", "frequency_events_not_users_giant.csv")

# Define Frequency Matrix Without users Data Frame
frequencyEventsDataFrameWithoutUsers = DataFrame(CSV.File(path))

# Convert to Lineal Algebra Matrix the Data Frame
frequencyMatrixEvents=
    Matrix(
        convert(Array{Float64}, 
        frequencyEventsDataFrameWithoutUsers)
    )

# Doing ZScoreTransform process
dt = fit(ZScoreTransform, Matrix(frequencyMatrixEvents), dims=2)

# Doing normalization process
normalizeFrequencyMatrixEvents=
    StatsBase.transform(
        dt, 
        Matrix(frequencyMatrixEvents)
    )
# Export in CSV the normalize data
createNormalizationFrequencyMatrixCSV(normalizeFrequencyMatrixEvents)