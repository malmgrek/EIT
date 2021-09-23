
struct ForwardSolver

    mesh::Mesh
    predict::Function
    plot::Function
    save::Function

end


struct InverseSolver

    mesh::Mesh
    fit::Function
    plot::Function
    save::Function

end


"""
Two-dimensional CEM FE solver

    - Lagrange P1 elements for conductivity
    - Lagrange P1 elements for potential
    - Smoothness penalty for fitting

"""
function Cem2dP1Smoothness(mesh)
    
    function predict(currents, conductivity)
    
        # Build FEM system from `mesh`
        # Solve FEM system
        # Return solved potential

    end

    function fit(currents, voltages; noise_cov=nothing, alpha=.01)
        
        # Run Gauss-Newton method
        # Requires calculating Jacobian
        # Return conductivity estimate
    
    end

    plot = throw(UndefRefError)
    save = throw(UndefRefError)

    return InverseSolver(mesh, fit, plot, save)

end


"""
Two-dimensional CEM monotonicity method fitter
    
    - Lagrange P1 elements for conductivity
    - Lagrange P1 elements for potential

"""
function CEM2dP1Monotonicity(mesh)

    fit(x...) = throw(UndefRefError)
    plot(x...) = throw(UndefRefError)
    save(x...) = throw(UndefRefError)

    return InverseSolver(mesh, fit, plot, save)

end
