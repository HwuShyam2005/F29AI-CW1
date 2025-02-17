package uk.ac.hw.macs.search;

public class AStarMain {

    private static Node[][] convertGridToNodes(Node[][] nodeGrid, int[][] gridMap, int goalX, int goalY) {

        int rowCount = gridMap.length;
        int columnCount = gridMap[0].length;
        nodeGrid = new Node[rowCount][columnCount];

        // Initialize nodes with GridState for each cell in the grid
        for (int row = 0; row < rowCount; row++) {
              for (int column = 0; column < columnCount; column++) {
                nodeGrid[row][column] = new Node(new GridState(gridMap, column, row, goalX, goalY, gridMap[row][column]));
            }
        }

        // Establish connections (children) between nodes for valid movements
        // Movements: up, down, left, right
        for (int row = 0; row < rowCount; row++) {
            for (int column = 0; column < columnCount; column++) {
                // Move left if valid
                if (column > 0 && gridMap[row][column - 1] != 0) {
                    nodeGrid[row][column].addChild(nodeGrid[row][column - 1], gridMap[row][column]);
                }
                // Move right if valid
                if (column < gridMap[row].length - 1 && gridMap[row][column + 1] != 0) {
                    nodeGrid[row][column].addChild(nodeGrid[row][column + 1], gridMap[row][column]);
                }
                // Move up if valid
                if (row > 0 && gridMap[row - 1][column] != 0) {
                    nodeGrid[row][column].addChild(nodeGrid[row - 1][column], gridMap[row][column]);
                }
                // Move down if valid
                if (row < gridMap.length - 1 && gridMap[row + 1][column] != 0) {
                    nodeGrid[row][column].addChild(nodeGrid[row + 1][column], gridMap[row][column]);
                }
            }
        }

        return nodeGrid;
    }

    public static void main(String[] args) {
        // Define first grid (4x6) with goal at (5, 2)
        int rowCount1 = 4;
        int columnCount1 = 6;
        int goalX1 = 5;
        int goalY1 = 2;
        int[][] gridMap1 = {
            {1, 1, 0, 2, 1, 1},
            {2, 2, 1, 2, 1, 1},
            {1, 1, 0, 2, 2, 1},
            {2, 0, 0, 1, 2, 2},
        };

        // Define second grid (5x5) with goal at (3, 4)
        int rowCount2 = 5;
        int columnCount2 = 5;
        int goalX2 = 3;
        int goalY2 = 4;
        int[][] gridMap2 = {
            {1, 1, 0, 2, 1},
            {2, 1, 1, 2, 1},
            {1, 1, 0, 1, 1},
            {2, 1, 2, 1, 2},
            {2, 0, 0, 1, 2},
        };

        // Convert first grid to nodes and set the root node
        Node[][] nodeGrid1 = new Node[rowCount1][columnCount1];
        nodeGrid1 = convertGridToNodes(nodeGrid1, gridMap1, goalX1, goalY1);
        Node rootNode1 = nodeGrid1[0][0]; // Root node (start point)

        // Convert second grid to nodes and set the root node
        Node[][] nodeGrid2 = new Node[rowCount2][columnCount2];
        nodeGrid2 = convertGridToNodes(nodeGrid2, gridMap2, goalX2, goalY2);
        Node rootNode2 = nodeGrid2[0][0]; // Root node (start point)

        // Initialize A* search order for both grids
        SearchOrder searchOrder1 = new AStarSearchOrder();
        SearchProblem searchProblem1 = new SearchProblem(searchOrder1);

        SearchOrder searchOrder2 = new AStarSearchOrder();
        SearchProblem searchProblem2 = new SearchProblem(searchOrder2);

        // Print Grid 1
        System.out.println("\nGrid 1:\n");
        for (int row = 0; row < rowCount1; row++) {
            for (int column = 0; column < columnCount1; column++) {
                System.out.print(gridMap1[row][column] + " ");
            }
            System.out.println();
        }

        // Perform A* search on Grid 1
        System.out.println("\nSearching Grid 1...\n");
        searchProblem1.doSearch(rootNode1);

        // Print Grid 2
        System.out.println("\nGrid 2:\n");
        for (int row = 0; row < rowCount2; row++) {
            for (int column = 0; column < columnCount2; column++) {
                System.out.print(gridMap2[row][column] + " ");
            }
            System.out.println();
        }

        // Perform A* search on Grid 2
        System.out.println("\nSearching Grid 2...\n");
        searchProblem2.doSearch(rootNode2);
    }
}
