function createFrequencyEventsMatrixCSV(frequencyEventsMatrix::DataFrame)
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "frequency_events_users_giant.csv"
            )
    CSV.write(path, frequencyEventsMatrix)
end

function createFrequencyEventsMatrixNotUsersCSV(
    frequencyEventsDataFrameWithoutUsers::DataFrame)
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "frequency_events_not_users_giant.csv"
            )
    CSV.write(path, frequencyEventsDataFrameWithoutUsers)
end

function createNormalizationFrequencyMatrixCSV(
    normalizeFrequencyMatrixEvents::Array{Float64,2})
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "normalize_data_frequency_matrix_giant.csv"
            )
    CSV.write(path, DataFrame(normalizeFrequencyMatrixEvents))
end

function createDimensionalityReductionDataCSV(
    dimensionality_reduction_data::Array{Float32,2})
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "dimensionality_reduction_data.csv"
            )
    CSV.write(path, DataFrame(dimensionality_reduction_data))
end

function createClusteringResultsCSV(dataClustering::DataFrame)
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "data_clustering_giant_events.csv"
            )
    CSV.write(path, dataClustering)
end

function createFeatureEngineeringDataCSV(dataFeatureEngineering::DataFrame)
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "data_giant_feature_engineering.csv"
            )
    CSV.write(path, dataFeatureEngineering)
end