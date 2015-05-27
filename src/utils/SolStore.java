package utils;

import java.util.ArrayList;
import java.util.Hashtable;

public class SolStore {
	// Each Hashtable represents one solution (a mapping between var names and values).
	private ArrayList<Hashtable> solutions;
	private int pointer;
	
	public SolStore(ArrayList<Hashtable> solutions){
		this.solutions=solutions;
		pointer=-1;
	}
	
	// Advances the pointer till the next solution. If all solutions have been read the store is cleared.
	public boolean nextSolution(){
		this.pointer++;
		if(this.pointer>=solutions.size()){
			solutions.clear();
			return false;
		}
		return true;
	}
	
	// Dereference a specific variable from the current solution.
	public Object dereferenceVar(String varName){
		return this.solutions.get(pointer).get(varName);
	}
}
