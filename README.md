# FlowFieldPathfinding

Repo for a project I did on a method of pathfinding optimised for lots of interactions with a static map. 

The best route to a destination is first calculated using a version of [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) and saved. People can then interact with this using a lookup table rather than needing to calculate anything.

First a graph of random weights is generated using random numbers or [Perlin Noise](https://en.wikipedia.org/wiki/Perlin_noise). Walls can be added which are impassable.
![Image](https://github.com/wrb06/FlowFieldPathfinding/blob/master/pictures/2d%20costmap%20.png)

Then a costmap is calculated. Objects given basic movement physics that interact with this costmap seem to flow like a liquid, giving the method its name.
![Image](https://github.com/wrb06/FlowFieldPathfinding/blob/master/pictures/2d%20flow%202.png)

Plotting this on a 3d axis gives interesting results as well. Though in this case because the goal (in red) is in the center the high cost areas seem to form walls around it.

![Image](https://github.com/wrb06/FlowFieldPathfinding/blob/master/pictures/3d%20flow%202.png)

You can see it better in this example:
![Image](https://github.com/wrb06/FlowFieldPathfinding/blob/master/pictures/2d%20flow.png)
![Image](https://github.com/wrb06/FlowFieldPathfinding/blob/master/pictures/3d%20flow.png)
