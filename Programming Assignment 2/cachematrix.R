## Changed function makeVector to cache a matrix.

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x ### Why not just * get <- x * ? 
        setinverse <- function(inverse) m <<- inverse ## why <<- ?
        getinverse <- function() m ### Why not just * getinverse <- m * ? 
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}

## Changed function cachemean to invert the matrix.

cacheSolve <- function(x, ...) {
        m <- x$getinverse()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- solve(data) 
        x$setinverse(m)
        m
}
