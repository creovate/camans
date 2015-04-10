/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.utility;

import camans.entity.Benefit;
import java.util.Comparator;

/**
 *
 * @author soemyatmyat
 */
/**
 * This comparator sorts the benefit by issued date
 */
public class BenefitComparator implements Comparator<Benefit> {
    @Override
    
    
    public int compare(Benefit b1, Benefit b2){
        return b1.getIssueDate().compareTo(b2.getIssueDate());
    }
}
