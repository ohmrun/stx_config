package stx.config;

using Bake;
using stx.Test;

class Test{
  static public function main(){
    __.test().run([
      new ParseDefinesTest()
    ],[]);    
  }
}
class ParseDefinesTest extends TestCase{
  public function test(){
    final bake = Bake.pop();
    //final v(bake.defines.search(x -> x.key == "no.quotes")); 
  }
}