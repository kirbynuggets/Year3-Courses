/** 
 * This is a sample Java program 
 * to demonstrate comment removal.
 */

 public class Q2input {
    public static void main(String[] args) {
        System.out.println("Starting program..."); // Print message

        int a = 10; // Initialize variable
        int b = 20; // Another variable

        /* Perform addition */ int sum = a + b; /* Inline comment */

        System.out.println("Sum: " + sum); // Print sum

        /* Multi-line 
         * comment explaining 
         * the following logic 
         */
        if (sum > 20) { 
            System.out.println("Sum is greater than 20"); /* Inline condition comment */
        } else {
            System.out.println("Sum is 20 or less"); 
        }
        
        System.out.println("End of program"); // Final message

        String str = "Text with comment inside /* should not be removed */ here"; 

        /** 
         * Another doc comment 
         * to test extraction
         */
    }
}
