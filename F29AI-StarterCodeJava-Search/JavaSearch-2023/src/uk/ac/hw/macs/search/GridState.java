package uk.ac.hw.macs.search;

public class GridState implements State {
    private int[][] gridMap;    // The grid representing the search space
    private int currentX;       // Current x-coordinate of the state
    private int currentY;       // Current y-coordinate of the state
    private int targetX;        // Goal x-coordinate
    private int targetY;        // Goal y-coordinate
    private int movementCost;   // Movement cost to reach this state

    public GridState(int[][] gridMap, int currentX, int currentY, int targetX, int targetY, int movementCost) {
        this.gridMap = gridMap;
        this.currentX = currentX;
        this.currentY = currentY;
        this.targetX = targetX;
        this.targetY = targetY;
        this.movementCost = movementCost;
    }

    /**
     * Determines if the current state is the goal state by comparing the current coordinates
     * with the goal coordinates.
     */
    @Override
    public boolean isGoal() {
        return (this.currentX == targetX && this.currentY == targetY);
    }

    /**
     * Returns the x-coordinate of the current state.
     */
    public int getCurrentX() {
        return currentX;
    }

    /**
     * Returns the y-coordinate of the current state.
     */
    public int getCurrentY() {
        return currentY;
    }

    /**
     * Calculates the heuristic value for the A* search algorithm.
     * The heuristic used here is the Manhattan distance (sum of the absolute differences between 
     * the current and goal coordinates), which estimates the cost to reach the goal.
     */
    @Override
    public int getHeuristic() {
        return Math.abs(this.currentX - targetX) + Math.abs(this.currentY - targetY);
    }

    /**
     * Returns the movement cost associated with this state.
     */
    public int getMovementCost() {
        return this.movementCost;
    }

    /**
     * Returns a string representation of the GridState, including the current position,
     * heuristic value, and movement cost.
     */
    @Override
    public String toString() {
        return "(X=" + currentX + ", Y=" + currentY + "), heuristic value is =" + getHeuristic() + ", movement cost is=" + getMovementCost();
    }
}
