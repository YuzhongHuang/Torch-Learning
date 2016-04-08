-- Yuzhong Huang yuzhong.huang@students.olin.edu
-- randomly split a KTH video tensor to trainset and testset

math.randomseed(os.time())-- seed the random with local time

datasets = torch.load("../datasets.t7") -- load datasets
vidNum = datasets['vids']:size(1) -- get the total video numbers

--initialize a numbered list of size of total video number 
numLst = {}
for i=1,vidNum do
	numLst[i] = i
end

-- define the shuffle table function
local function shuffleTable(t)
    local rand = math.random 
    assert(t, "shuffleTable() expected a table, got nil")    
    for i = #t, 2, -1 do
        local j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

shuffleTable(numLst) -- shuffle the numbered list

-- define a function that shuffle the order of a tensor provided by the key withnin a copy of the datasets
local function shuffleData(data, copy, lst, key)
	for i = 1, #lst, 1 do
		local j = lst[i]
		copy[i] = data[key][j]
	end
end

vidsCopy = torch.Tensor(datasets['vids']:size()):copy(datasets['vids']) -- create a copy of the videos data
labelsCopy = torch.Tensor(datasets['labels']:size()):copy(datasets['labels']) -- create a copy of the labels data

shuffleData(datasets, vidsCopy, numLst, 'vids') -- shuffle videos
shuffleData(datasets, labelsCopy, numLst, 'labels') -- shuffle labels

