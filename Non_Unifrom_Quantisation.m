function mu_law_quantisation()
sequence_length=500;
mu=255;

input_sequence=randn(1,sequence_length);
quantisation_level=[16,64,128];

for i=1:length(quantisation_level)

    quantised_sequence=mu_quantise(input_sequence,quantisation_level(i),mu);

    figure;
    subplot(2,1,1);
    plot(input_sequence,quantised_sequence,'o');
    title("Input-Output relation - Quantisation Levels : ",num2str(quantisation_level(i)));
    xlabel("Input");
    ylabel("Output");

    error=input_sequence-quantised_sequence;
    subplot(2,1,2);
     plot(1:sequence_length,error,'-');  
    title("Error - Quantisation Levels : ",num2str(quantisation_level(i)));
    xlabel("Input");
    ylabel("Output");

    sqnr=10*log10(sum(input_sequence.^2)/sum(error.^2));
    fprintf("The sqnr for the sequence of quantisation levels %d is : %.2f dB", quantisation_level(i),sqnr);
end
end

function quantised_sequence = mu_quantise(input_sequence,num_levels,mu)
    
input_sequence=input_sequence/max(abs(input_sequence));

compressed_sequence=sign(input_sequence).*(log(1+mu*abs(input_sequence))/log(1+mu));

quantised_sequence=round((num_levels-1)*(compressed_sequence+1)/2);
end