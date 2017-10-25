/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package multiplier;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.*;
import java.io.*;
import java.nio.*;
import java.nio.channels.*;
public class Multiplier {
    /* converting string to digits    */
    private static byte[] stringToDigits(String num) {
        byte[] result = new byte[num.length()];
        for (int i = 0; i < num.length(); i++) {
            char c = num.charAt(i);
            if (c < '0' || c > '9') {
                throw new IllegalArgumentException("Invalid digit " + c
                        + " found at position " + i);
            }
            result[num.length() - 1 - i] = (byte) (c - '0');
        }
        return result;
    }

    /* Deinition of longmult()    */
    public static String longMult(String num1, String num2) {
        byte[] left = stringToDigits(num1);
        byte[] right = stringToDigits(num2);
        byte[] result = new byte[left.length + right.length];
        for (int rightPos = 0; rightPos < right.length; rightPos++) {
            byte rightDigit = right[rightPos];
            byte temp = 0;
            for (int leftPos = 0; leftPos < left.length; leftPos++) {
                temp += result[leftPos + rightPos];
                temp += rightDigit * left[leftPos];
                result[leftPos + rightPos] = (byte) (temp % 10);
                temp /= 10;
            }
            int destPos = rightPos + left.length;
        }
        StringBuilder stringResultBuilder = new StringBuilder(result.length);
        for (int i = result.length - 1; i >= 0; i--) {
            byte digit = result[i];
            if (digit != 0 || stringResultBuilder.length() > 0) {
                stringResultBuilder.append((char) (digit + '0'));
            }
        }
        return stringResultBuilder.toString();
    }
    public static void main(String args[]) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));       
        String s=", ";
        System.out.println("Enter First Multiplier ");   
        String input1 = br.readLine();
        System.out.println("Enter second Multiplier ");   
        String input2 = br.readLine();

        BufferedWriter writer = new BufferedWriter(new FileWriter("InputFile")); // InputFile is file which holds multiplier
        writer.write(input1);
        writer.write(s);
        writer.write(input2);
        writer.close();   
        // Reading from memorymapped files
        File file = new File("InputFile");
        FileChannel fc = new RandomAccessFile(file, "rw").getChannel();
        ByteBuffer bb = fc.map(FileChannel.MapMode.READ_ONLY, 0, (int) fc.size());
        String line;
        BufferedReader br1 = new BufferedReader(new FileReader("InputFile"));
        line=br1.readLine();
       
        StringTokenizer st = new StringTokenizer(line,s); 
    
        String multiplier1 = st.nextToken();
        String multiplier2 = st.nextToken();
        System.out.println("Multiplier1: " + multiplier1);
        System.out.println("Multiplier2: " + multiplier2);
        System.out.println("Final Result: " + longMult(multiplier1,multiplier2)); //calling longmult function
    }
}