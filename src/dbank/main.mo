import Debug "mo:base/debug";  // importing a module name Debug.
import Time "mo:base/Time";
import Float "mo:base/Float";

actor Dbank{
  // this stable keyword is going to store the value of the variable no matter what happen. now it is a orthogonal presistance variable. this variable gonna remember his state.
  stable var currentValue: Float = 300;  // with var variable we can change the as we want but we can't do the same with the let keyword.
  //currentValue := 100;  // Keep an eye on the operator we used in motoko.

  stable var startTime = Time.now();  // To print the time
  Debug.print(debug_show(startTime));

  Debug.print("Hello");  // this command is used to print the string.

  Debug.print(debug_show(currentValue));  // this command is used to print the numbers.

  public func topUp(amount: Float) {
    // function to increment the value.
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    // function to decrement the value.
    let tempValue: Float = currentValue - amount;
    if(tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero");
    }
    };

    public query func checkBalance(): async Float {
      // these are much more faster.
      return currentValue;
    };

    public func compound() {
      let currentTime = Time.now();
      let timeElapsedNS = currentTime - startTime;
      let timeElapsedS = timeElapsedNS / 1000000000;
      currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedNS));
      startTime := currentTime;
    }

}
// as long as we are not changing any variable or state of something, then we can use ultra fast query calls. and if we want to update the state this process is going to be little slower and we have to use the update call.

// Orthogonal persistance - the idea of persistance is being able to hold onto state over many different cycles and updates