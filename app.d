import core.sys.windows.windows;
import std.stdio;
import std.string;
import std.conv;

extern (Windows) {
    DWORD GetLogicalDriveStringsA(DWORD nBufferLength, LPSTR lpBuffer);
}

void main() {
    char[260] buffer; // El tamaño máximo para GetLogicalDriveStrings es 260
    DWORD drives = GetLogicalDriveStringsA(cast(DWORD) buffer.length, buffer.ptr);

    if (drives == 0) {
        writeln("Error al obtener las letras de unidad.");
        return;
    }

    writeln("Letras de unidad disponibles:");

    auto splitDrives = split(buffer[0 .. cast(ulong)drives], '\0'); // Dividir la cadena en partes

    foreach (drive; splitDrives) {
        writeln(to!string(drive)); // Convertir cada parte a una cadena y escribir
    }
}
