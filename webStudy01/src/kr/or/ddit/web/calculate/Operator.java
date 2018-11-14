package kr.or.ddit.web.calculate;

public enum Operator {
   ADD("+",new RealOperator() {
      @Override
      public int operate(int left, int right) {
         return left+right;
      }
   }), 
   MINUS("-",(left,right)->{return left-right;}),
   MULTIPLY("*",(a,b)->{return a*b;}),
   DIVIDE("/",(c,d)->{return c/d;});
   
   private String sign;
   private RealOperator realOperator;
   Operator(String sign,RealOperator realOperator){
      this.sign = sign;
      this.realOperator = realOperator;
   }
   public String getSign(){
      return this.sign;
   }
   public int operator(int left,int right) {
      return realOperator.operate(left,right);
   }
}