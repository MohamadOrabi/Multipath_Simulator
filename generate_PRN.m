function [CAcode, Converted] = generate_PRN(i,j)

G1 = ones(1,10);
G2 = ones(1,10);

    for m = 1:1023
        %Phase selector Output
        G2i = mod(G2(i)+G2(j),2);
        CAcode(m) = mod(G2i+G1(10),2);

        newBit1 = mod(G1(3)+G1(10),2);
        G1 = [newBit1 G1(1:9)];

        newBit2 = mod(G2(2)+G2(3)+G2(6)+G2(8)+G2(9)+G2(10),2);
        G2 = [newBit2 G2(1:9)];
    end
    
    Converted = (CAcode == 0) * 1 + (CAcode == 1) * -1;
    
end