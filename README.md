# ConsulR

Managing code for a number of clients can be difficult, as every client has their own style and needs. Therefore, while it should be encouraged that code be written according to established styles, and using technologies like packages, RProject files, markdowns and version control, the client should be respected in their programming decisions as much as possible.

This package is a work-in-progress for creating a consistent, reliable product with flexibility to allow for multiple styles, but allowing the code to be run, edited and tested in a safe environment.
    
The functions in this package can:
- check that an R script runs to completion without error in a clean R environment.
- allow for code to be commented out or lines added while editing on the developer side to ensure they work, and have these operations reversed when shipping back to the client.
- provides a safe method to load Rdata files into a list rather than saving over objects in the environment.
