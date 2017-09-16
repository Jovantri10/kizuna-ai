class Familiar
    def initialize(name, caster, process)
        @name = name
        @summoner = caster
        @process = process
    end

    def summoner
        @summoner
    end

    def kill
        Process.kill("INT", @process.pid)
        @process.close
    end
end
