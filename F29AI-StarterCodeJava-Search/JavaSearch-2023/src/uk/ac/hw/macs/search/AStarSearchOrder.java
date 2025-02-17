package uk.ac.hw.macs.search;

import java.util.Comparator;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Set;

public class AStarSearchOrder implements SearchOrder {

    private PriorityQueue<FringeNode> priorityQueue;  // Priority queue for nodes in A* search

    public AStarSearchOrder() {
        Comparator<FringeNode> comparator = Comparator
            .comparingInt(FringeNode::getFValue)      // Compare based on f-value (g + h)
            .thenComparingInt(node -> node.gValue);    // Tie-breaker: compare by g-value (cost)

        priorityQueue = new PriorityQueue<>(comparator);  // Initialize the queue with the comparator
    }

    @Override
    public void addToFringe(List<FringeNode> openList, FringeNode parentNode, Set<ChildWithCost> children) {
        // Loop through each child node and its corresponding transition cost
        for (ChildWithCost childWithCost : children) {
            Node childNode = childWithCost.node;               // Child node to be processed
            int costToChild = childWithCost.cost;              // Transition cost from parent to child

            // Skip if the transition cost is zero (invalid move)
            if (costToChild == 0) {
                continue;
            }

            // Create a new FringeNode for the child using the calculated transition cost
            FringeNode newFringeNode = new FringeNode(childNode, parentNode, costToChild);
            int newFValue = newFringeNode.getFValue();         // Calculate the f-value (g + h) for this node

            boolean isNodePresent = false;

            // Check if the child node already exists in the open list
            for (FringeNode existingFringeNode : openList) {
                if (existingFringeNode.node.equals(childNode)) {
                    isNodePresent = true;

                    // Replace the node if the new one has a lower f-value
                    if (newFValue < existingFringeNode.getFValue()) {
                        openList.remove(existingFringeNode);
                        openList.add(newFringeNode);
                    }
                    break;  // Stop once the existing node is processed
                }
            }

            // Add the new node to the open list if it wasn't already present
            if (!isNodePresent) {
                openList.add(newFringeNode);
            }
        }

        // Sort the open list by f-value and tie-break using g-value
        openList.sort(Comparator
            .comparingInt(FringeNode::getFValue)
            .thenComparingInt(node -> node.gValue));
    }

}
