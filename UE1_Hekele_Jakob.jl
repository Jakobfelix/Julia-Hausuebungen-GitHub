
#=
Fuege in dieses Template deine Loesungscodes ein.
Wichtig 1: Die Datei gemaess der Namensrichtlinien benennen.
Wichtig 2: Bitte nur die Funktionen ausprogrammieren und keine Funktionsaufrufe vornehmen.
=#

using Random


### Beispiel 1:

function greatest(x::Vector{T}, k::Integer = 1) :: Vector{T} where {T <: Real}
    if k <= 0
        throw(ArgumentError("k muss groesser als 0 sein!"))
    end

    if k > length(x)
        throw(ArgumentError("k muss kleiner sein als die Anzahl der Elemente von x"))
    end

    x_sort = sort(x, rev = true)
    x_max = x_sort[1:k]
    bool = x .∈ Ref(x_max)
    res = x[bool]

    return(res)
end


### Beispiel 2

function nearestindex(x::Vector{<:Real}, y::Real) :: Int
    x_diff = abs.(x .- y)
    x_min = minimum(x_diff)
    bool = x_diff .∈ x_min
    ind = findall(bool)

    # Anmerkung: Falls kritisiert wird, dass wir die Funktion findall nicht
    # besprochen haben, die which aus R aehnelt, ein alternativer 
    # Loesungsvorschlag, der mir ein bisschen weniger gefaellt:

    # bool = x_diff .∈ Ref(x_min)
    # ind = (1:length(x))[bool]

    Random.shuffle!(ind)
    

    return(ind[1])
end


### Beispiel 3

function swap!(x::Vector, i::Integer, j::Integer) :: Nothing
    x[i], x[j] = x[j], x[i]
    return nothing
end

function bubblesort!(x::Vector{<:Real}; rev::Bool = false) :: Nothing
    swaps = 1
    if !rev
        while swaps > 0
            swaps = 0
            for i in 1:(length(x) - 1)
                if x[i] > x[i + 1]
                    swap!(x, i, i+1)
                    swaps += 1
                end
            end
        end
    end

    if rev
        while swaps > 0
            swaps = 0
            for i in 1:(length(x) - 1)
                if x[i] < x[i + 1]
                    swap!(x, i, i+1)
                    swaps += 1
                end
            end
        end
    end
    
    return nothing
end


### Beispiel 4

function canonicaltour(x::Vector{T}) :: Vector{T} where {T <: Integer}
    if sort(x) != 1:length(x)
        throw(ArgumentError("Argument x muss eine Permutation natuerlichen Zahlen von 1 bis length(x) sein!"))
    end


    if x[1] == 1
        pushfirst!(x, x[end])
        deleteat!(x, length(x))
    end

    if x[end] == 1
        push!(x, x[1])
        deleteat!(x, 1)
    end

    bool = x .∈ 1
    ind = (1:length(x))[bool][1]


    if x[ind - 1] < x[ind + 1]
        res = vcat(1, reverse(x[1:(ind - 1)]), reverse(x[(ind + 1):length(x)]))
    end

    if x[ind - 1] > x[ind + 1]
        res = vcat(1, x[(ind + 1):length(x)], x[1:(ind - 1)])
    end

    return(res)
end


### Beispiel 5

function distance(x::Vector{<:Real}, y::Vector{<:Real}; p::Real = 2)
    if length(x) != length(y)
        throw(ArgumentError("Fehler: x und y haben nicht dieselbe Laenge!"))
    end

    if p <= 0
        throw(ArgumentError("Fehler: p muss positiv sein!"))
    end

    res = sum(((abs.(x - y)) .^ p)) ^ (1 / p)
    return(res)
end

