import java.util.*;

ArrayList<Node> nodes = new ArrayList();
ArrayList<Link> links = new ArrayList();

HashMap<Character, String> temp = new HashMap<Character, String>();
//String input = "helloooooooowoooooorllllllddddddddddddddddd";

String s="",s_temp="";
char [] t =new char[255];
int taille=0,draw=0;

void setup() {
  size(1200,800);
  background(0);
}
void draw() {
   textSize(20);
  fill(0);
  if(draw == 0){
     background(255);
     text("Input String: "+s_temp,20,50);
   }
   for (int i=0; i<nodes.size (); i++) {
     nodes.get(i).draw();
   }
   for (int i=0; i<links.size (); i++) {
     links.get(i).draw();
   }
}


HashMap nboccurences(String input) {
  HashMap<Character, Integer> occ = new HashMap<Character, Integer>();
  int nbocc;

  for (char ch : input.toCharArray()) {
    nbocc = 0;
    if ( !occ.containsKey(ch)) {
      for (char c : input.toCharArray()) {
        if (c == ch) {
          nbocc++;
        }
      }
      occ.put(ch, nbocc);
    }
  }
  return sortByValue(occ);
}


public static HashMap<Character, Integer> sortByValue(HashMap<Character, Integer> hm) 
    { 
        List<Map.Entry<Character, Integer> > list = new LinkedList<Map.Entry<Character, Integer> >(hm.entrySet()); 
        
        Collections.sort(list, new Comparator<Map.Entry<Character, Integer> >() { 
            public int compare(Map.Entry<Character, Integer> o1,  
                               Map.Entry<Character, Integer> o2) 
            { 
                return (o1.getValue()).compareTo(o2.getValue()); 
            } 
        }); 
        
        HashMap<Character, Integer> temp = new LinkedHashMap<Character, Integer>(); 
        for (Map.Entry<Character, Integer> aa : list) { 
            temp.put(aa.getKey(), aa.getValue()); 
        } 
        return temp; 
    }
    
    
class NoeudHuffman {
 
    int data;
    char c;
    
    NoeudHuffman left;
    NoeudHuffman right;
}


class MyComparator implements Comparator<NoeudHuffman> {
    public int compare(NoeudHuffman x, NoeudHuffman y)
    {
        return x.data - y.data;
    }
}


void printCode(NoeudHuffman root, String s) {
  if (root.left == null && root.right == null && Character.isLetter(root.c)) {
    temp.put(root.c,s);
    System.out.println(root.c + ":" + s);
    return;
  }
  printCode(root.left, s + "0");
  printCode(root.right, s + "1");
}


String huffmanCoding(String s) {
  HashMap<Character, Integer> occ = new HashMap<Character, Integer>();
  occ = nboccurences(s);
  
  println();
  println("Nombre d’occurrences de chaque caractère trié: "+occ+"\n");
  
  PriorityQueue<NoeudHuffman> q = new PriorityQueue<NoeudHuffman>(occ.size(), new MyComparator());
  
  for (char k : occ.keySet()) {
    NoeudHuffman hn = new NoeudHuffman();
    
    hn.c = k;
    hn.data = occ.get(k);
    
    hn.left = null;
    hn.right = null;
    
    q.add(hn);
  }
  
  NoeudHuffman root = null;
  
  while (q.size() > 1) {
    
            NoeudHuffman x = q.peek();
            q.poll();
            
            NoeudHuffman y = q.peek();
            q.poll();
            
            NoeudHuffman f = new NoeudHuffman();
            
            f.data = x.data + y.data;
            f.c = '-';
            f.left = x;
            f.right = y;
            
            root = f;
            
            q.add(f);
        }
        println("Le code correspondant pour chaque element :");
        printCode(root, "");
        
        String coded = new String();
        
        for (char ch : s.toCharArray()) {
          for(char k : temp.keySet()) {
            if(ch == k) {
              coded = coded + temp.get(k);
            }
          }
        }
        println("\nHuffman coded string : "+coded);
        
        float px = width/2 ,py = 200;
        NoeudHuffman temp = q.peek();
        /*while (temp.left != null && temp.right != null) {
          nodes.add( new Node(""+temp.data, px, py ));
        }*/
        return coded;
        
        /*NoeudHuffman temp = q.;
        String decoded = new String();
        for (char ch : s.toCharArray()) {
          if(ch == '0') {
            temp = 
          }
          else {
          }
        }*/
        
}

String maptoString(HashMap<Character, String> hm) {
  String val = "{ ";
  for (char k : hm.keySet()) {
    val = val + k + ":" + hm.get(k) + " ";
  }
  val = val + "}";
  return val;
}

void keyPressed() {
  s=new String();
  if(key != '\n'){
    t[taille]=key;
    taille++;
    s_temp=new String(t,0,taille);
  }
  else {
    s=new String(t,0,taille);
    t=new char[55];
    if(draw==0)
    text("Huffman coded string : "+huffmanCoding(s),20,150);
    text("Huffman coding values : "+maptoString(temp),20,100);
    taille=0;draw=1;
  }
}






















class Node {
 
  String name;
  float px, py;
  color c;
 
  // constr
  Node(String name_, float px_, float py_) {
    px=px_;
    py=py_;
    name=name_;
    c=color(random(255), random(255), random(255));
  } // constr
 
  void draw() {
    // show a circle 
    fill(c);
    stroke(0);
    ellipse(px, py, 50, 50);
 
    // show the name of the node 
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, px, py);
 
    // the mouse over effect 
    /*if (dist(mouseX, mouseY, px, py)<=10) {
      // show the name of the node 
      fill(0);
      textAlign(CENTER, CENTER);
      text(name, px, py-22);
    }*/
  } // method
} // class
 
// ==========================================
 
class Link {
 
  String from;
  String to;
 
  // constr
  Link(String _from, String _to) {
    from=_from;
    to=_to;
  } // constr
 
  void draw() {
    // show the lines 
    float px1=-1, py1=-1, px2=-1, py2=-1;
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).name.equals(from)) {
        px1 = nodes.get(i).px;
        py1 = nodes.get(i).py;
      }
      if (nodes.get(i).name.equals(to)) {
        px2 = nodes.get(i).px;
        py2 = nodes.get(i).py;
      }
    } // for
    strokeWeight(2);
    stroke(0);
    line(px1, py1, px2, py2);
  } // method
} // class 
//
