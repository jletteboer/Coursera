## Author: John Letteboer
## Date: Februari 5, 2018
## ---------------------------------
##  Caching the Inverse of a Matrix 
## ---------------------------------
## Matrix inversion is usually a costly computation and there may be 
## some benefit to caching the inverse of a matrix rather than compute 
## it repeatedly. 

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        # get the value of the matrix
        get <- function() x

        # set the value of the inverse
        setinv <- function(inverse) inv <<- inverse

        # get the value of the inverse
        getinv <- function() inv
        list(set = set, 
             get = get,
             setinv = setinv,
             getinv = getinv)
}


## This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. If the inverse has already been calculated (and 
## the matrix has not changed), then the cachesolve should retrieve the 
## inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv <- x$getinv()

        # Checks to see if the inverse has already been calculated. 
        # If so, it gets the inverse from the cache and skips the computation. 
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }

        # If not in cache, calculate the inverse of the data and sets the value 
        # of the inverse in the cache via the setinv function.
        data <- x$get()
        inv <- solve(data, ...)
        x$setinv(inv)
        inv
}
