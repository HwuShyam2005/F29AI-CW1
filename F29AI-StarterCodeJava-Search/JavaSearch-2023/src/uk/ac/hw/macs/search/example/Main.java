public class Main {

	private static boolean BlackspaceG1(int x, int y) {
		if ((x == 2 && y == 0) || (x == 2 && y == 2) || (x == 2 && y == 3) || (x == 1 && y == 3))
			return true;
		else
			return false;
	}

	private static boolean isWallG2(int x, int y) {
		if ((x == 2 && y == 0) || (x == 2 && y == 2) || (x == 2 && y == 4) || (x == 1 && y == 4))
			return true;
		else
			return false;
	}

	private static int squareCostG1(int x, int y) {
		if ((x == 0 && y == 1) || (x == 1 && y == 1) || (x == 3 && y == 0) || (x == 3 && y == 1) || (x == 3 && y == 2)
				|| (x == 4 && y == 2) || (x == 0 && y == 3) || (x == 4 && y == 3) || (x == 5 && y == 3))
			return 2;
		else
			return 1;
	}

	private static int squareCostG2(int x, int y) {
		if ((x == 3 && y == 0) || (x == 0 && y == 1) || (x == 3 && y == 1) || (x == 0 && y == 3) || (x == 0 && y == 4)
				|| (x == 2 && y == 3) || (x == 4 && y == 4) || (x == 4 && y == 3))
			return 2;
		else
			return 1;
	}

	public static void main(String[] args) throws Exception {
		int g1Cols = 6;
		int g1Rows = 3;
		
		Node goal = new Node(new GridState(5, 2, true));
		Node[][] grid = new Node[g1Cols][g1Rows];

		for (int x = 0; x < g1Cols; x++) {
			for (int y = 0; y < g1Rows; y++) {
				grid[x][y] = new Node(new GridState(x, y, goal));
			}
		}

		grid[5][2] = goal;

		for (int x = 0; x < g1Cols; x++) {
			for (int y = 0; y < g1Rows; y++) {
				if (BlackspaceG1(x, y))
					continue;

				boolean Left = true, Right = true, Up = true, Down = true;
				if (x == 0)
				Left = false;
				if (x == 5)
				Right = false;
				if (y == 0)
				Up = false;
				if (y == 2)
				Down = false;

				if (Left && !BlackspaceG1(x - 1, y))
				    grid[x][y].addChild(grid[x - 1][y], squareCostG1(x - 1, y));
				if (Right && !BlackspaceG1(x + 1, y))
				    grid[x][y].addChild(grid[x + 1][y], squareCostG1(x + 1, y));
				if (Up && !BlackspaceG1(x, y - 1))
				    grid[x][y].addChild(grid[x][y - 1], squareCostG1(x, y - 1));
				if (Down && !BlackspaceG1(x, y + 1))
				    grid[x][y].addChild(grid[x][y + 1], squareCostG1(x, y + 1));
			}
		}

		int g2Cols = 4;
		int g2Rows = 5;

		goal = new Node(new GridState(3, 4, true));
		Node[][] grid2 = new Node[g2Cols][g2Rows];

		for (int x = 0; x < g2Cols; x++) {
			for (int y = 0; y < g2Rows; y++) {
				grid2[x][y] = new Node(new GridState(x, y, goal));
			}
		}

		grid2[3][4] = goal;

		for (int x = 0; x < g2Cols; x++) {
			for (int y = 0; y < g2Rows; y++) {
				if (isWallG2(x, y))
					continue;

				boolean Left = true, Right = true, Up = true, Down = true;

				if (x == 0)
					Left = false;
				if (x == 3)
					Right = false;
				if (y == 0)
					Up = false;
				if (y == 4)
					Down = false;

				if (Left && !isWallG2(x - 1, y))
					grid2[x][y].addChild(grid2[x - 1][y], squareCostG2(x - 1, y));
				if (Right && !isWallG2(x + 1, y))
					grid2[x][y].addChild(grid2[x + 1][y], squareCostG2(x + 1, y));
				if (Up && !isWallG2(x, y - 1))
					grid2[x][y].addChild(grid2[x][y - 1], squareCostG2(x, y - 1));
				if (Down && !isWallG2(x, y + 1))
					grid2[x][y].addChild(grid2[x][y + 1], squareCostG2(x, y + 1));
			}
		}

		SearchOrder order = new AStarSearchOrder();
		SearchProblem problem = new SearchProblem(order);

		problem.doSearch(grid[0][0]);

		System.out.println("\n");
		System.out.println("----------------------\n");
		System.out.println("\n");
		
		problem.doSearch(grid2[0][0]);
	}
}