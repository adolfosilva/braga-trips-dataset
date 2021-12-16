Mix.install([{:jason, "~> 1.2"}, {:httpoison, "~> 1.8"}])

defmodule Transformer do
  @choices %{
    "bike" => ["FXS-490", "UIY-388", "YGW-739", "XLE-733", "SZN-403", "IPH-100",
     "JPF-367", "GDK-127", "KGB-153", "ZXH-414", "XGU-457", "CFS-892", "HNG-251",
     "VGQ-250", "KVH-882", "QKT-544", "XYJ-097", "ZQA-625", "LRB-259", "QYI-528",
     "VDU-246", "VYA-359", "CLW-945", "KYP-892", "JGB-229", "CMC-854", "ZDX-908",
     "GNE-452", "DCP-107", "NRF-289", "CAP-503", "ERW-220", "FZO-025", "GPU-404",
     "LWV-179", "ZTQ-768", "WPO-520", "DAF-744", "FND-831", "DDG-912", "AFO-679",
     "PUQ-932", "GGP-270", "QYR-755", "AIH-011", "QNC-725", "UBA-365", "PKE-742",
     "ISZ-277", "KJE-582"],
    "scooter" => ["AOJ-955", "DUY-611", "HIO-469", "JGE-495", "JDL-301",
     "RCK-485", "FFY-939", "HDF-687", "STN-715", "NKG-254", "QSF-693", "ACX-685",
     "YHJ-604", "FXM-387", "BAK-515", "WDU-652", "ZIK-452", "SCK-959", "MOO-755",
     "HIE-858", "YEN-798", "RPV-591", "FGO-706", "EOQ-117", "YYL-278", "DSJ-779",
     "MFI-686", "AVM-930", "RZR-259", "XSA-680", "PPC-820", "LLF-426", "UZZ-419",
     "QWL-283", "MOJ-702", "SZA-507", "ZSH-377", "YBN-106", "WYS-892", "ZOH-285",
     "JJC-866", "YXE-397", "WSV-378", "OQM-560", "JHP-713", "VQF-721", "RYN-295",
     "BYA-718", "DLR-794", "NBV-472", "ELI-366", "KEB-810", "DFR-253", "HXE-729",
     "AWC-719", "IFG-484", "AHI-017", "MXF-753", "MZU-195", "APL-852", "NUU-427",
     "LLC-902", "BOF-981", "RRQ-583", "MAK-357", "AQB-732", "UTK-039", "AWK-868",
     "XQD-640", "NEW-014", "PKE-421", "YRZ-700", "CLK-503", "ZMQ-553", "LGB-400",
     "OKT-810", "HBW-765", "NDD-226", "KWI-880", "JUN-062", "JQC-260", "TSG-474",
     "GZQ-478", "UOU-974", "ZPV-036", "PXA-747", "IAD-016", "UQI-043", "GIC-030",
     "GRG-336", "NCH-310", "OHK-552", "SYQ-909", "TEU-886", "SMN-145", "OKM-248",
     "RKL-951", "KTQ-327", "VLM-732", "ZJZ-735", "QIN-014", "FGZ-006", "LXS-663",
     "JTE-495", "NJY-335", "NYB-586", "ISE-777", "QES-967", "SOU-614", "QJH-665",
     "LEX-619", "YOT-151", "DLZ-391", "KIC-666", "KZG-776", "HQA-276", "ZFO-153",
     "TTE-673", "ZFW-558", "LAP-947", "JMA-625", "QEF-044", "JYZ-434", "ZKH-342",
     "KVM-796", "VXS-453", "XRR-341", "FQC-511", "LDU-243", "BLD-358", "BJL-657",
     "BUV-701", "UOH-612", "RAO-844", "FSE-163", "NNY-487", "DMY-738", "TTD-169",
     "FFG-582", "JDR-850", "FXE-891", "EVJ-197", "WOB-334", "JRD-146", "TVA-087",
     "AYV-438", "BNK-723", "DPI-597", "NFR-461", "JYJ-404"]
   }

  def run(filepath) do
    json = filepath |> File.read!() |> Jason.decode!()

    transform(json)
  end

  def generate_id() do
    x = Enum.map(0..2, fn _ -> Enum.random(?A..?Z) end)
    y = Enum.map(0..2, fn _ -> Enum.random(?0..?9) end)
    "#{x}-#{y}"
  end

  def transform(json) do
    # ids = Enum.map(0..199, fn _ -> generate_id() end)
    # choices = %{"scooter" => Enum.take(ids, 150), "bike" => Enum.drop(ids, 150)}

    # we are assuming all elements have the same type!
    vehicle_type = Enum.at(json["features"], 0) |> get_in(["properties", "vehicle_type"])

    new_features =
      Enum.map(json["features"], fn x ->
        put_in(x, ~w|properties vehicle_id|, Enum.random(@choices[vehicle_type]))
      end)

    Map.replace(json, "features", new_features)
  end
end

case System.argv() do
  [] ->
    raise ArgumentError, message: "Provide file as argument"

  [path] ->
    ext = Path.extname(path)
    outpath = Path.basename(path, ext) <> "_norm" <> ext
    IO.puts("Writing transformation to #{outpath}")
    json = Transformer.run(path)
    :ok = File.write(outpath, Jason.encode!(json))

    # vehicle_ids = Enum.map(json["features"], fn x -> get_in(x, ["properties", "vehicle_id"]) end)
    # freq = Enum.frequencies(vehicle_ids)
    # IO.inspect(freq, limit: :infinity)
    # Map.keys(freq) |> Enum.count() |> IO.puts()
end

