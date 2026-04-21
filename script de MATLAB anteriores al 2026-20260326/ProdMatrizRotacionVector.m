function vectorRot=ProdMatrizRotacionVector(matrizRot,vector)
            vector=cat(3, vector,vector,vector);
            vector=permute(vector,[3 2 1]);
            
           % vector=permute(vector,[3 1 2]);
            matrizRot = permute(matrizRot,[2 3 1]);
            vectorRot=sum(matrizRot.*vector,2);
            
            vectorRot=permute(vectorRot,[3 1 2]);
            
           % vectorRot=permute(vectorRot,[1 3 2]);
           
end