#define min(a,b) ((a) < (b) ? (a) : (b))
#define max(a,b) ((a) < (b) ? (a) : (b))

struct point {
        int x;
        int y;
}; 
struct rect {
    struct point p1;
    struct point p2;
};
struct point make_point(int x, int y);
struct point add_point(struct point p1, struct point p2);
int point_in_rect(struct point p, struct rect r);
struct rect canon_rect(struct rect r);

int main(){
    struct point p1 = {1,2};    
    return 0;
}

struct point make_point(int x, int y){
    struct point temp = {x,y};
    return temp;
}

struct point add_point(struct point p1, struct point p2){
    struct point temp;
    temp.x = p1.x + p2.x;
    temp.y = p1.y + p2.y;
    return temp;
}

int point_in_rect(struct point p, struct rect r){
    if (r.p1.x <= p.x && p.x < r.p2.x &&
        r.p1.y <= p.y && p.y < r.p2.y)
        return 1;
    else
        return 0;
}

struct rect canon_rect(struct rect r){
    struct rect temp;
    temp.p1.x = min(r.p1.x,r.p2.x);
    temp.p1.y = min(r.p1.y,r.p2.y);
    temp.p1.x = max(r.p1.x,r.p2.x);
    temp.p1.y = max(r.p1.y,r.p2.y);
    return temp;
}
