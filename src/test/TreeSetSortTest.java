package test;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Collections;  
import java.util.Comparator;  
import java.util.List;  
import java.util.TreeSet;  
  

public class TreeSetSortTest {  
    public static final int DEFAULT_ARRAY_LENGTH =  10*1000 * 1000;  
  
    private List<Integer> createList(int arrLength) {  
        List<Integer> numbers = new ArrayList<Integer>();  
        for(int i = 0; i < DEFAULT_ARRAY_LENGTH; i++) {  
            numbers.add(i);  
        }  
        Collections.shuffle(numbers);  
        return numbers;  
    }  
    public long testCollectionsSort(List<Integer> numbers) {  
        //Ticker ticker = Ticker.systemTicker();  
        long startTime = System.currentTimeMillis();  
        Collections.sort(numbers, new Comparator<Integer>() {  
            public int compare(Integer o1, Integer o2) {  
                return o1.compareTo(o2 );  
            }  
        });  
        //long endTime = ticker.read();  
        //System.out.println("[testCollectionsSort]" + (endTime - startTime) / 1000);  
        //System.out.println("[testCollectionsSort]" + numbers.toString());  
        return (System.currentTimeMillis() - startTime);  
    }  
  
    public long testSortedMap(List<Integer> numbers) {  
       // Ticker ticker = Ticker.systemTicker();  
        long startTime = System.currentTimeMillis();    
        TreeSet<Integer> sortedNumberSet = new TreeSet<Integer>(new Comparator<Integer>() {  
            public int compare(Integer o1, Integer o2) {  
                return o1.compareTo(o2);  
            }  
        });  
        sortedNumberSet.addAll(numbers);  
        //long endTime = ticker.read();  
        //System.out.println("[testSortedMap]" + (endTime - startTime) / 1000);  
        //List<Integer> newNumbers = Lists.newArrayList(sortedNumberSet);  
        //System.out.println("[testSortedMap]" + newNumbers.toString());  
        return (System.currentTimeMillis() - startTime) ;  
    }  
  
    @Test  
    public void testSortMethodCompare() {  
        int loopCount = 10;  
        long collectionsSortTimeTotalCount = 0;  
        long sortedMapTimeTotalCount = 0;  
        List<Integer> numbers = createList(DEFAULT_ARRAY_LENGTH);  
        for(int i = 0; i < loopCount; i ++) {  
            List<Integer> tempNumbers = new ArrayList<Integer>(numbers);//每次循环使用同样数据  
            sortedMapTimeTotalCount += testSortedMap(tempNumbers);//不会改变tempNumbers  
            collectionsSortTimeTotalCount += testCollectionsSort(tempNumbers);  
        }  
        long collectionsSortTimeCount = collectionsSortTimeTotalCount / loopCount;  
        long sortedMapTimeCount = sortedMapTimeTotalCount / loopCount;  
        System.out.println("[testSortMethodCompare] loopCount = " + loopCount  
                + ",listSize = " + DEFAULT_ARRAY_LENGTH);  
        System.out.println("[CollectinSort]" + collectionsSortTimeCount + "毫秒");  
        System.out.println("[SortedMapSort]" + sortedMapTimeCount + "毫秒");  
    }  
    public static void main(String[] args) {
		new TreeSetSortTest().testSortMethodCompare();
	}
}  